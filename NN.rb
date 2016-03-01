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
  attr_accessor :layers,:links, :node_num, :nodes, :conf, :errs, :output_nodes, :n

  def initialize(conf)
    @conf = conf ;
    @layers = [] ; 
    @links = [] ;   #配列で階層を表現
    @nodes = [] ;
    @errs = {} ;
    @n = 0.1 ;
    @output_nodes = [] ;
    @input_datas = [] ;
    @teacher_datas = {} ;
    @node_num = 0 #ノードカウント用
    @traning_data = @conf[:training_data] ;
    # set_input_teacher_value() ;
    create_nn()  #設定ファイルからNNを生成
  end

  #
  # === 訓練データと教師データの格納
  #
  def set_input_teacher_value()
    input_datas = @conf[:input_datas] ;

    i = @conf[:all_node_num] ;
    min_output_num = @conf[:all_node_num]-@conf[:output_node_num] ;
    while i > min_output_num
      @teacher_datas[:i] = @nodes[i].get_value ;
      i -= 1 ;
    end
  end

  #
  # === 設定ファイルからNNを生成
  #
  def create_nn()
    #入力層、隠れそう、出力層の初期化
    # create_layer(conf[:input_node_num]) 
    # create_hidden_layers(conf[:hidden_layer])
    # create_layer(conf[:output_node_num])

    create_nodes(@conf[:all_node_num])  ;
    #リンクをつなげる
    create_links(@conf[:links_conf]) ; 
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
  # === 入力と伝搬
  #
  def propagation(input_data)
    input_practice_data(@conf[:input_node_num], input_data) ;

    @links.each do |link|
       from_node = @nodes[link.get_from.get_id] ;
       to_node = @nodes[link.get_to.get_id] ;
       to_node.set_value(link.w * to_node.get_value()) ;  #重み付きの値を代入
    end
  end

  
  #
  # === 訓練データの入力
  #
  def input_practice_data(input_node_num,input_data)
    input_node_num.times do |n|
      @nodes[n].set_value(input_data[n]) ;
    end
  end

  #
  # === 出力値との誤差を求める
  #
  def calc_err(teacher_datas)
    i = @conf[:all_node_num]-1 ;
    min_output_num = @conf[:all_node_num]-@conf[:output_node_num] ;
    while i > min_output_num
      binding.pry ;
      @errs[i] = -1 * ( @nodes[i].get_w - teacher_data[:i] ) ;
      i -= 1 ;
    end
  end

  #
  # === 誤差逆伝搬
  #
  def back_propagation()
    delta = {} ;
    @links.reverse_each do |link|

      to_node = link.get_to ;
      from_node = link.get_from ;

      # if errs[i] がnillじゃなければ（出力層に直結したリンクであれば)
      if is_output_node(from_node)  #出力ノードに結合していれば
        delta[link] = @errs[to_node] * to_node.get_w * (1.0 - to_node.get_value);
      else
        delta[link] = calc_delta(delta, link) * to_node.get_value * (1.0 - to_node.get_value) ;
      end
      # else errsを計算 の代入
      # delta の計算
      # delta_weightの計算
      delta_weight = -1 * @n * delta[link] *link.get_from.get_value ;
      link.set_weight( link.get_weight + delta_weight ) ;
    end
  end
 
  #
  # === 上のノード
  #
  def calc_delta(delta, link)
    from = link.get_to ;
    sum = 0 ;
    @links.each do |l|
       if l.get_from == from
         sum += l.get_weight * delta[l] ;
       end
    end

    return sum ;
  end

  #
  # === 入力ノードかどうかの判定
  #
  def is_input_node(node)
   return true if node.get_id <  @conf[:input_node_num]
   return false ;  
  end

  #
  # === 出力ノードかどうかの判定
  #
  def is_output_node(node)
    i = @conf[:all_node_num] ;
     min_output_num = @conf[:all_node_num]-@conf[:output_node_num] ;

     while i > min_output_num
      if node.get_id == i
        return true ;
      end
      i -= 1 ;
     end
    return false ;
  end


  #
  # === 訓練するメソッド
  #
  def training
    
  end

  #
  #  ================================================
  #

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
  conf = YAML.load_file("nodeSetting.yml") ;
  nn = NN.new(conf) ;
  training_num = 100 ;
  training_num.times do |num|
    training_data = conf[:training_data][rand(conf[:training_data].size)][:input] ;
    teacher_datas= conf[:training_data][rand(conf[:training_data].size)][:output] ;
    nn.propagation(training_data) ;
    nn.calc_err(teacher_datas) ;
    nn.back_propagation ;
  end
  binding.pry ;
end


