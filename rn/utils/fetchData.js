export default async (url, options) => {
    const {method, headers, body} = options;
    let {timeout} = options;

    timeout = timeout || 20000;

    const newOptions = Object.assign({}, options, {
        credentials: 'same-origin',
    });

    const timeoutPromise = new Promise((resolve, reject) => {
        setTimeout(() => {
            reject({
                response: 'timeout',
            });
        }, timeout);
    });

    if (method && (method.toUpperCase() === 'POST' || method.toUpperCase() === 'PUT' || method.toUpperCase() === 'DELETE')) {
        if (headers && headers['Content-Type'] === 'application/x-www-form-urlencoded') {
            const params = [];
            if (body instanceof Object) {
                Object.keys(body).forEach((item) => {
                    params.push(`${item}=${body[item]}`);
                });
            }
            newOptions.body = params.join('&');
        } else if (headers && headers['Content-Type'] === 'application/json') {
            newOptions.body = JSON.stringify(body);
        } else if (!(body instanceof FormData)) {
            newOptions.body = new FormData(body);
        }
    } else if (method && method.toUpperCase() === 'GET' && body) {
        const searchPath = Object.keys(body).map(item => `${item}=${body[item]}`).join('&');
        if (searchPath !== '') {
            url = `${url}?${searchPath}`;
        }
        delete newOptions.body;
    }
    try {
        let ecode = '';
        let bcode = '';
        const response = await Promise.race([fetch(url, newOptions), timeoutPromise,]);
        if ((response.status >= 200 && response.status < 300)
            || response.status === 304) {
            const responseJson = await response.json();
            console.log(url, newOptions.body, responseJson)
            const code = parseInt(responseJson.code, 10);
            bcode = code;
            if (code !== 1) {
                const error = new Error(`resultCode: ${code} ${responseJson.resultDes}`);
                error.response = responseJson;
                throw error;
            }


            return responseJson;
        } else {
            const error = new Error(response.statusText);
            error.response = response;

            throw error;
        }
        ;
    } catch (err) {
        !err.response && (err.response = 'other');
        throw err;
    }
}
