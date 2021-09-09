<?php
declare (strict_types = 1);

namespace app\api\controller;

use think\admin\Controller;
use think\facade\Db;
use think\Request;

class Hotupdate extends Controller
{
        /**
     * 绑定数据表
     * @var string
     */
    public $table = 'HotupdateBundles';
    /**
     * 显示资源列表
     *
     * @return \think\Response
     */
    public function checkUpdate()
    {
        if ($this->request->isPost()) {
        $post = $this->request->post();
        if(isset($post['bundleName']) && isset($post['subversion'])){
                $result = Db::table('hotupdate_bundles')
                    ->where([
                        ['subversion', '>', $post['subversion']]
                    ])
                    ->where('bundle_name', $post['bundleName'])
                    ->select();

                return json(['code' => 200, 'message' => '获取成功', 'data' => $result,'host'=> 'http://01f575191104e888.natapp.cc:5990', 'query' => Db::getLastSql()]);
        }else{
                return json(['code' => 400, 'message' => '参数错误'], 400);
        }
  
        }else{
            return json(['code'=>450,'message'=>'不支持的请求方式'],450);
        }
    }

    public function checkAllUpdate(){
        if ($this->request->isPost()) {
            $post = $this->request->post();

            if(isset($post['bundles'])){
           
                $bids = json_decode(stripslashes($post['bundles']),true);
      
                $sqls = [];
                foreach($bids as $biz){
                    if(isset($biz['bundleName'])&&isset($biz['subversion'])&&isset($post['platform'])){
                        $sql = Db::table('hotupdate_bundles')->where([
                            ['bundle_name', '=', $biz['bundleName']],
                            ['subversion', '>', $biz['subversion']],
                            ['platform', '=', $post['platform']],
                        ])->order('subversion', 'desc')->field("bsdiff_url,url,status,subversion,bundle_name")->limit(1)->buildSql();
                        array_push($sqls, $sql);
                    }
                }
                if(count($sqls)>0){
                $result = Db::table('hotupdate_bundles')->field("bsdiff_url,url,status,subversion,bundle_name")->where('bundle_name','=', '')->union($sqls)
                        ->select();
                }else{
                    $result = [];
                }
          

                return json(['code' => 200, 'message' => '获取成功', 'data' => $result, 'host' => "http://192.168.43.10:8000",'query' => Db::getLastSql(),'param'=>$post]);
            }else{
                return json(['code' => 200, 'message' => '获取成功1', 'data' => []]); 
            }
        } else {
            return json(['code' => 450, 'message' => '不支持的请求方式'], 450);
        }
    }

}
