#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

$LOAD_PATH.push(File::dirname($0)) ;
require "pry"
require "yaml"
require '/home/okano/lab/tkylibs/rubyOkn/BasicTool'
require '/home/okano/lab/tkylibs/rubyOkn/StringTool'

include BasicTool
include StringTool;

class SimplePerceptron 
  attr_accessor :w, :threshold, :input_nodes, :output_nodes ;

  def initialize(w=1, threshold=1)
    @w = w   ;  #重み
    @threshold = threshold ;  #しきい値
    @input_nodes = []  ;
    @output_nodes = []  ;
    initialize_input_nodes() ;
    initialize_output_nodes() ;
  end

  
  #
  # === 入力ノード郡の初期化
  #
  def initialize_input_nodes()

  end

  #
  # === 出力ノード郡の初期化
  #
  def initialize_input_nodes()

  end

end
#
# 実行用
#
if($0 == __FILE__) then
  
end


