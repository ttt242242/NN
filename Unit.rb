#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

$LOAD_PATH.push(File::dirname($0)) ;
require "pry"
require "yaml"
# require '/home/okano/lab/tkylibs/rubyOkn/BasicTool'
# require '/home/okano/lab/tkylibs/rubyOkn/StringTool'
require 'rubyOkn/BasicTool'
require 'rubyOkn/Object'

include BasicTool
# include StringTool;

#
# == シンプルユニット
#
class Unit < Object
  attr_accessor :w, :threshold, :link_list, :value ;

  def initialize(threshold=0, id=nil)
    # @w = w   ;  #重み
    super(id) ;
    @threshold = threshold ;  #しきい値
    @link_list = [] ;
    @value = 0.0 ;
  end

  #
  # === 信号の入力、発火するかどうかの決定
  # signal_list array 電気信号
  #
  def input_signals(signal_list)

  end

  
  #しきい値をセット
  def set_threshold(threshold)
    @threshold = threshold   ;  #しきい値をセット
  end

  #重みを返す 
  def get_w
    return @w ;
  end


  #しきい値を返す
  def get_threshold
    return @threshold ;
  end

  #
  # === link_listにlinkを加える
  #
  def add_link(link)
    link_list.push(link) ;
  end
 
  #
  # === 発火するかどうか
  #     check to fire or not
  #
  def is_fire(sum_value)
    if sum_value > @threshold  
      @value = 1 
    elsif sum_value == @threshold
      @value = 0
    else
      @value = -1
    end
  end

  #
  # === ノードの値をセット
  #     set @value
  #
  def set_value(value)
    @value = value;
  end

  #
  # === このノードの値を返す
  #     return @value
  #
  def get_value()
    return @value ;
  end
end

#
# 実行用
#
if($0 == __FILE__) then
  
end


