#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

$LOAD_PATH.push(File::dirname($0)) ;
require "pry"
require "yaml"
# require '/home/okano/lab/tkylibs/rubyOkn/BasicTool'
# require '/home/okano/lab/tkylibs/rubyOkn/StringTool'
require 'rubyOkn/BasicTool'

include BasicTool
# include StringTool;

#
# == リンク
#
class Link
  attr_accessor :from, :to, :w


  def initialize(from = nil, to = nil, w=0)
     @from = from if from != nil ;
     @to = to if to != nil ;
     # @w = rand() ;
     @w = 0.5 ;
  end

  def get_to  
    return @to ;
  end

  def get_from
    return @from ;
  end

  def set_to(to)
    @to = to ;
  end

  def set_from(from)
    @from = from ;
  end

  def get_weight()
    return @w ;
  end
  
  def set_weight(w)
    @w = w ;
  end

end

#
# 実行用
#
if($0 == __FILE__) then
  
end


