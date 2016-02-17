#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

$LOAD_PATH.push(File::dirname($0)) ;
require "pry"
require "yaml"
require '/home/okano/lab/tkylibs/rubyOkn/BasicTool'
require '/home/okano/lab/tkylibs/rubyOkn/StringTool'
require 'SimplePerceptron'

include BasicTool
include StringTool;


#
# == NNの実験用　3層のNNの実装 シンプルなパーセプトロンとは別で
# NNの形 などはこちらで決めてしまう
#
class NN 
  attr_accessor :layers
  def initialize()
    conf = YAML.load_file("nodeSetting.yml")
    @layers = [] 
    create_nn(conf)  #設定ファイルからNNを生成
  end

  #
  # === 設定ファイルからNNを生成
  #
  def create_nn(conf)
    #入力層、隠れそう、出力層の初期化
    create_layer(conf[:input_node_num]) 
    create_hidden_layers(conf[:hidden_layer])
    create_layer(conf[:output_node_num])

    #リンクをつなげる
    create_links(conf)
  end


  #
  # === 一層のノード群の生成
  #
  def create_layer(node_num)
    layer = [] 
    node_num.times do |n|
      layer.push(Unit.new)
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

  
  #
  # === リンクをつなげる
  #
  def create_links(conf)
    
  end

  #訓練データと出力データから学習
    #結果からの各リンクの更新について
end


#
# 実行用
#
if($0 == __FILE__) then
  
end


