class Product < ApplicationRecord
  has_many :orders
  has_many :users, through: :orders

  def self.user_pref(user)
    # product =
    Product.find_by(variety: user.variety, flow: user.flow, scent: user.scent)
  end

  # def self.box
	#   if @user.variety == "tampon" && @user.flow == "light" && @user.scent == "scent" then
	#   	return "tls"
	#   elsif @user.variety == "tampon" && @user.flow == "medium" && @user.scent == "scent" then
	#   	return "tms"
	#   elsif @user.variety == "tampon" && @user.flow == "heavy" && @user.scent == "scent" then
	#   	return "ths"
	#   elsif @user.variety == "pad" && @user.flow == "light" && @user.scent == "scent" then
	#   	return "pls"
	#   elsif @user.variety == "pad" && @user.flow == "medium" && @user.scent == "scent" then
	#   	return "pms"
	#   elsif @user.variety == "pad" && @user.flow == "heavy" && @user.scent == "scent" then
	#   	return "phs"
	#   elsif @user.variety == "combo" && @user.flow == "light" && @user.scent == "scent" then
	#   	return "cls"
	#   elsif @user.variety == "combo" && @user.flow == "medium" && @user.scent == "scent" then
	#   	return "cms"
	#   elsif @user.variety == "combo" && @user.flow == "heavy" && @user.scent == "scent" then
	#   	return "chs"
	#   elsif @user.variety == "tampon" && @user.flow == "light" && @user.scent == "unscent" then
	#   	return "tlu"
	#   elsif @user.variety == "tampon" && @user.flow == "medium" && @user.scent == "unscent" then
	#   	return "tms"
	#   elsif @user.variety == "tampon" && @user.flow == "heavy" && @user.scent == "unscent" then
	#   	return "thu"
	#   elsif @user.variety == "pad" && @user.flow == "light" && @user.scent == "unscent" then
	#   	return "plu"
	#   elsif @user.variety == "pad" && @user.flow == "medium" && @user.scent == "unscent" then
	#   	return "pmu"
	#   elsif @user.variety == "pad" && @user.flow == "heavy" && @user.scent == "unscent" then
	#   	return "phu"
	#   elsif @user.variety == "combo" && @user.flow == "light" && @user.scent == "unscent" then
	#   	return "clu"
	#   elsif @user.variety == "combo" && @user.flow == "medium" && @user.scent == "unscent" then
	#   	return "cmu"
	#   elsif @user.variety == "combo" && @user.flow == "heavy" && @user.scent == "scent" then
	#   	return "chu"
	#   else
  #   end
	# end
end
