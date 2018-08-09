class StaticPagesController < ApplicationController
  def index
    @money = StartScrap.new.perform
    @array = []
    i = 0
    while i < @money.keys.length do
      @array << [@money.keys[i], @money.keys[i]]
      i += 1
    end
      @name = params[:crypto]
      @rate = @money[params[:crypto]]
  end
end
