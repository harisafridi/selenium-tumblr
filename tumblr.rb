require 'selenium-webdriver'
require 'yaml'

browser = Selenium::WebDriver.for :firefox
browser.get "http://tumblr.com/login"
email = ''
password = ''
data = YAML.load(File.open('form.yml'))
 data['credentials'].each do |yaml|
 email = yaml['email']
 password = yaml["password"]
 end
elementemail = browser.find_element id: "signup_email"
elementemail.send_keys "#{email}"
elementpass = browser.find_element id: "signup_password"
elementpass.send_keys "#{password}"
elementpass.submit

post_blog = browser.find_element id: "new_post_label_text"
post_blog.click

blog_text = browser.find_element class: "editor-richtext"
blog_text.send_keys "Testing something"

post_button = browser.find_element class: "create_post_button"
post_button.click

body = browser.find_elements(class: "post_body")

found = false
body.each do |o| 
   if (o.text).match /Testing something/
	puts "Found! \n Your post is: #{o.text}" 
	found = true 
	end
end
print "not found" if found == false