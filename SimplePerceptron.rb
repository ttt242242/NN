#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

#================================================
# 一つのノードと複数のlinkからなるパーセプトロン
# this perceptron is made from a unit and some links
# Links have some weights 
#================================================

$LOAD_PATH.push(File::dirname($0)) ;
require "pry"
require "yaml"
require "Unit"
require "Link"
# require '/home/okano/lab/tkylibs/rubyOkn/BasicTool'
# require '/home/okano/lab/tkylibs/rubyOkn/StringTool'

include BasicTool
include StringTool;

#
# == 単純なパーセプトロン
#
class SimplePerceptron 
  # attr_accessor :w, :threshold, :input_units, :output_units ;
  attr_accessor :input_units,:output_unit, :links ;

  def initialize(input_unit_num=4,link_num=4)
    @input_units = Array.new ;
    @links = Array.new ;
    initialize_units(input_unit_num) ;
    initialize_links(link_num) ;
    # initialize_output_units() ;
  end

  
  #
  # === 入力ノード郡の初期化
  # @param input_datas Array
  #
  def initialize_units(unit_num)
    @output_unit = Unit.new();  #出力unitの生成
    unit_num.times do |unit_num|
      @input_units.push(Unit.new()) ; #入力ユニットの生成
    end
  end

  #
  # === 各unitに訓練データをセットするメソッド
  # 
  def set_practice_value(e_array) 
    @input_units.zip(e_array).each do |unit, e|
      unit.set_value(e) ;
    end
  end

  #
  # === 出力ノードの初期化
  # @param unit Unit
  # @param link_num Integer :number of links
  #
  def initialize_links(link_num)
    link_num.times do |link_num|
      @links.push(Link.new(@input_units[link_num],@output_unit, 0.0)) 
    end
  end

  #
  # === 各リンクの重みの更新
  #     update w from learning data and practice data
  #
  def update_links_w(supervised_data)
    #各ノードからの入力値と重みを掛けたもの計算
    sum_value = 0 ;
    @links.zip(@input_units).each do |link, unit|
      sum_value += link.w * unit.value ;
    end
    #上記の値をoutput_unitに投げて判断させる
    output_unit.is_fire(sum_value)  ;
    result_value = @output_unit.get_value() ;

    # 判断結果によって各重みの修正
    if result_value != supervised_data 
       #各リンクの重みの修正
       @links.zip(@input_units).each do |link,unit|
          link.w = link.w + ( supervised_data.to_f * unit.value.to_f ) 
       end
    end

    return result_value ;
  end

end

#
# 以下テスト用
#
if($0 == __FILE__) then
  e = [[1, -1, -1, -1], [1, 1, -1, -1], [1, 1, 1, 1]]  ; #3パターンの訓練データ
  c = [1, -1, 1] #正解データ
  #ランダムで訓練データを更新した,input_nodesのセット set input_units updated by practice_data
  simple_perceptron = SimplePerceptron.new() ;
  
  10000.times do |time| 
    #学習回数分学習を行う   
    data_num = rand(0..2)
    
    simple_perceptron.set_practice_value(e[data_num]) ;
    result = simple_perceptron.update_links_w(c[data_num]) ;

    if result == c[data_num] 
      p "○"
    else
      p "☓"
    end
    #正当率を出力する
  end
end



