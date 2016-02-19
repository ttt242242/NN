#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

$LOAD_PATH.push(File::dirname($0)) ;
require "pry"
require "yaml"
require "Unit"
require "Link"
# require '/home/okano/lab/tkylibs/rubyOkn/BasicTool'
require 'rubyOkn/BasicTool'
# require 'SimplePerceptron'

include BasicTool
# include StringTool;


#
# == NNの実験用　3層のNNの実装 シンプルなパーセプトロンとは別で
# NNの形 などはこちらで決めてしまう
#
class NN 
  attr_accessor :layers,:links, :node_num, :nodes

  def initialize()
    conf = YAML.load_file("nodeSetting.yml")
    @layers = [] ; 
    @links = [] ;   #配列で階層を表現
    @nodes = [] ;
    @node_num = 0 #ノードカウント用
    create_nn(conf)  #設定ファイルからNNを生成
  end

  #
  # === 設定ファイルからNNを生成
  #
  def create_nn(conf)
    #入力層、隠れそう、出力層の初期化
    # create_layer(conf[:input_node_num]) 
    # create_hidden_layers(conf[:hidden_layer])
    # create_layer(conf[:output_node_num])

    create_nodes(conf[:all_node_num])  ;
    #リンクをつなげる
    create_links(conf[:links_conf]) ; 
  end

  #
  # === 一層のノード群の生成
  #
  def create_nodes(node_num)
    # layer = []  ;
    node_num.times do |n|
     @nodes.push(Unit.new(0,n)) ;
      # @node_num += 1 ;
    end
    # @layers.push(layer) ;
  end

  #
  # === リンクをつなげる
  #
  def create_links(links_conf)
    links_conf.each do |link_conf|
      @links.push(Link.new(@nodes[link_conf[:from]],@nodes[link_conf[:to]]));
    end

  end


  #
  # === 一層のノード群の生成
  #
  def create_layer(node_num)
    layer = [] 
    node_num.times do |n|
      layer.push(Unit.new(0,@node_num))
      @node_num += 1
    end
    @layers.push(layer)
  end

  #
  # === 隠れ層のノードの生成
  #
  def create_hidden_layers(conf)
    conf[:hidden_layer].each do |node_num|
      create_layer(node_num)
    end
  end

  
  
  #訓練データと出力データから学習
    #結果からの各リンクの更新について
end


#
# 実行用
#
if($0 == __FILE__) then
  t = NN.new   
end


