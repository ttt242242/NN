#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

$LOAD_PATH.push(File::dirname($0)) ;
require "pry"
require "yaml"
require '/home/okano/lab/tkylibs/rubyOkn/BasicTool'
require '/home/okano/lab/tkylibs/rubyOkn/StringTool'

include BasicTool
include StringTool;

#
# == シンプルユニット
#
class Unit
  attr_accessor :w, :threshold, :link_list ;

  def initialize(w=1, threshold=1)
    @w = w   ;  #重み
    @threshold = threshold ;  #しきい値
    @link_list = [] ;
  end

  #
  # === 信号の入力、発火するかどうかの決定
  # signal_list array 電気信号
  #
  def input_signals(signal_list)

  end

  #重みをセット
  def set_w(w)
    @w = w   ;  #重み
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

end

#
# 実行用
#
if($0 == __FILE__) then
  
end


