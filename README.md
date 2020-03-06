安装过程
------------


1.  安装nix 并配置channel

    ```console
    $ sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
    $ curl https://nixos.org/nix/install | sh

    $ nix-channel --add https://nixos.org/channels/nixos-20.03 nixos-20.03
    $ nix-channel --update nixos-20.03

    ```

2.  添加home-manager channel

    ```console
    $ nix-channel --add https://github.com/clojurians-org/home-manager/archive/master.tar.gz home-manager
    $ nix-channel --update
    ```


3.  安装home-manager工具

    ```console
    $ nix-shell '<home-manager>' -A install
    ```


使用方法
-------
 
1.  编写配置(参见larluo-conf/home.nix)
```nix
{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.stateVersion = "19.09";

  
  environment.systemPackages = [
    pkgs.coreutils
    pkgs.inetutils
    pkgs.unixtools.netstat
    pkgs.findutils
    pkgs.dnsutils
    pkgs.gnused
    pkgs.less
    pkgs.gawk
    pkgs.procps
    pkgs.cron
    pkgs.nix-bundle

    pkgs.tmux
    pkgs.emacs
    pkgs.vim
    pkgs.cloc
    pkgs.git
    pkgs.gitAndTools.gitSVN
    pkgs.cachix

    pkgs.gcc
    pkgs.jre
    pkgs.cabal-install
    pkgs.obelisk
    pkgs.yarn
    pkgs.gradle
    pkgs.clojure
    pkgs.lombok
    pkgs.clang-tools
    pkgs.dhall
    pkgs.python38
    # pkgs.vue (no-darwin yet)
    pkgs.maven

    pkgs.tree
    pkgs.jq
    pkgs.avro-tools
    pkgs.curl
    pkgs.wget
    pkgs.ws
    pkgs.aria2
    pkgs.wrk
    pkgs.unzip
    pkgs.xz

    pkgs.pandoc
    pkgs.privoxy

    pkgs.redis
    pkgs.postgresql_11
    # pkgs.mysql80
    pkgs.mysql57
    pkgs.elasticsearch7
    pkgs.neo4j
    pkgs.apacheKafka
    pkgs.confluent-platform
    pkgs.kafkacat

    pkgs.minio
    pkgs.minio-client
    pkgs.neo4j
    # pkgs.clickhouse (no-darwin yet)
    pkgs.cassandra

    # pkgs.imagemagick
    # pkgs.shadowsocks-libev
    pkgs.fish
  ];

  services.privoxy = {
    enable = false ;
    listenAddress = "0.0.0.0:8118" ;
    config = "forward-socks5 / 0.0.0.0:1080 ." ;
  } ;

  services.redis = {
   enable = true ;
   dataDir = "/opt/nix-module/data/redis" ;
   unixSocket = "/opt/nix-module/run/redis.sock" ;
  } ;

  services.postgresql = { 
    enable = true ; 
    package = pkgs.postgresql_11 ;
    dataDir = "/opt/nix-module/data/postgresql" ;
  } ;

  services.mysql = {
    enable = true ;
    # package = pkgs.mysql80 ;
    package = pkgs.mysql57 ;
    dataDir = "/opt/nix-module/data/mysql" ;
    unixSocket = "/opt/nix-module/run/mysql.sock" ;
  } ;

  services.elasticsearch = {
    enable = true ;
    package = pkgs.elasticsearch7 ;
    dataDir = "/opt/nix-module/data/elasticsearch" ;
  } ;
  
  services.neo4j = {
    enable = true ;
    package = pkgs.neo4j ;
    directories.home = "/opt/nix-module/data/neo4j" ;
  } ;
}

```


2.  激活生效
    ```console
    $ export NIX_PATH=~/.nix-defexpr/channels
    $ home-manager -I home-manager=<home-manager> -f larluo-conf/home.nix  switch
    ```

开发模式
--------
    下载github到本地进行调试
    ```console
    $ git clone https://github.com/clojurians-org/home-manager.git
    $ cd home-manager
    $ nix-shell -A install
    $ home-manager -I home-manager=. -f larluo-conf/home.nix  switch
    ```

