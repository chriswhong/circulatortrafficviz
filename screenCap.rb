require 'selenium-webdriver'
width = 1280 
height = 720 

def repeat_every(interval)
  Thread.new do
    loop do
      start_time = Time.now
      yield
      elapsed = Time.now - start_time
      sleep([interval - elapsed, 0].max)
    end
  end
end

thread = repeat_every(45) do

begin
      start_time = Time.now
      d = Selenium::WebDriver.for :firefox 
      d.navigate.to 'http://www.jfxart.com/circulator' 
      d.execute_script %Q{ 
      window.resizeTo(#{width}, #{height}); 
      }
      n = Time.now.to_i
      s = n.to_s

      d.save_screenshot(s+'.png') 
      d.quit 

  end
end
puts "Waiting..."
thread.join
