AutoHtml.add_filter(:image) do |text|
  text.gsub(/http(s?):\/\/.+.(jpg|jpeg|bmp|gif|png)(\?\S+)?/i) do |match|
    %|<img src="#{match}" alt="" width="100%" />|
  end
end
