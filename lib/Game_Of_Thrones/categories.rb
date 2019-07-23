class GameOfThrones::Categories

  subpage = Nokogiri::HTML(open(GameOfThrones::Controller.selector))
   subcategories = subpage.css("div.col-4-lg.col-6-md.col-6-sm.product-panel.product-panel-height-new")


end
