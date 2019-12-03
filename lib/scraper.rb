require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_array = doc.css(".student-card a")

    student_array.map do |student|

      {:name => student.css("h4").text,
      :location => student.css("p").text,
      :profile_url => student.attr('href')}
#binding.pry
  end
end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    students = {}
      profile = doc.css(".vitals-container .social-icon-container a")

      profile.each do |element|
        if element.attr('href').include?("twitter")
          students[:twitter] = element.attr("href")

        elsif  element.attr('href').include?("linkedin")
          students[:linkedin] = element.attr("href")

        elsif  element.attr('href').include?("github")
          students[:github] = element.attr("href")

        elsif  element.attr('href').end_with?("com/")
          students[:blog] = element.attr("href")
        end
      end

      students[:profile_quote] = doc.css(".profile-quote").text
      students[:bio] = doc.css(".description-holder p").text
      students
    end

end
