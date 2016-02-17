#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

$LOAD_PATH.push(File::dirname($0)) ;
require "pry"
require "yaml"
require 'rubyOkn/BasicTool'
require 'rubyOkn/StringTool'
require 'SimplePerceptron'

include BasicTool
include StringTool;


#
# == NNの実験用　3層のNNの実装 シンプルなパーセプトロンとは別で
# NNの形 などはこちらで決めてしまう
#
# class MakeSetting
#     
# end
conf = Hash.new() ;

#入力層のノード数
print "input input's node num(integer)"
conf[:input_node_num] = gets.to_i
#隠れそうの層数
print "input number of the layer(integer)"
layer_num = gets.to_i
conf[:hidden_layer] = Array.new 
layer_num.times do 
  #層数分繰り返す
  print "input node num in layer #{layer_num}"
  conf[:hidden_layer].push(gets.to_i)
end
  

#出力層のノード数
print "input number of output's node(integer)"
conf[:output_node_num] = gets.to_i

makeYamlFile("nodeSetting.yml", conf) ;


