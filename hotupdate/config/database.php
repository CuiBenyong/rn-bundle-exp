<?php

// +----------------------------------------------------------------------
// | ThinkAdmin
// +----------------------------------------------------------------------
// | 版权所有 2014~2020 广州楚才信息科技有限公司 [ http://www.cuci.cc ]
// +----------------------------------------------------------------------
// | 官方网站: http://demo.thinkadmin.top
// +----------------------------------------------------------------------
// | 开源协议 ( https://mit-license.org )
// +----------------------------------------------------------------------
// | gitee 代码仓库：https://gitee.com/zoujingli/ThinkAdmin
// | github 代码仓库：https://github.com/zoujingli/ThinkAdmin
// +----------------------------------------------------------------------

return [
    // 默认使用的数据库连接配置
    'default'         => 'mysql',
    // 自定义时间查询规则
    'time_query_rule' => [],
    // 自动写入时间戳字段
    'auto_timestamp'  => true,
    // 时间字段取出后的默认时间格式
    'datetime_format' => 'Y-m-d H:i:s',
    // 数据库连接配置信息
    'connections'     => [
        'mysql' => [
            // 数据库类型
            'type'              => 'mysql',
            // 服务器地址
            'hostname'          => '127.0.0.1',
            // 数据库名
            'database'          => 'hotupdate',
            // 用户名
            'username'          => 'root',
            // 密码
            'password'          => 'Shl1018a..',
            // 端口
            'hostport'          => '3306',
            // 数据库连接参数
            'params'            => [],
            // 数据库编码默认采用utf8
            'charset'           => 'utf8mb4',
            // 数据库表前缀
            'prefix'            => '',
            // 数据库调试模式
            'debug'             => true,
            // 数据库部署方式:0 集中式(单一服务器),1 分布式(主从服务器)
            'deploy'            => 0,
            // 数据库读写是否分离 主从式有效
            'rw_separate'       => false,
            // 读写分离后 主服务器数量
            'master_num'        => 1,
            // 指定从服务器序号
            'slave_no'          => '',
            // 是否严格检查字段是否存在
            'fields_strict'     => true,
            // 是否需要断线重连
            'break_reconnect'   => false,
            // 字段缓存路径
            'schema_cache_path' => app()->getRootPath() . 'runtime' . DIRECTORY_SEPARATOR . 'schema' . DIRECTORY_SEPARATOR,
        ],
    ],
];
