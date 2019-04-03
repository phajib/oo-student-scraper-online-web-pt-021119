require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html_link = Nokogiri::HTML(open(index_url))
    students = []

    #  Iterate through the card/s
    html_link.css("div.roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each do |student|
        # binding.pry
        profile = "#{student.attr('href')}"
        location = student.css('.student-location').text
        name = student.css('.student-name').text
        # student hash details inside students array
        students << {name: name, location: location, profile_url: profile}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html_link = Nokogiri::HTML(open(profile_url))
    student = {}

    card = html_link.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      card.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
        end
      end
    student[:profile_quote] = html_link.css(".profile-quote").text
    student[:bio] = html_link.css("div.description-holder p").text
    student
  end

end