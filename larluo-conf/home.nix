{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
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
    pkgs.zookeeper
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
  services.zookeeper = {
    enable = true ;
    package = pkgs.zookeeper ;
    dataDir = "/opt/nix-module/data/zookeeper" ;
  } ;
}
