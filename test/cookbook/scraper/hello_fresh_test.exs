defmodule Cookbook.Scraper.HelloFreshTest do
  use Cookbook.DataCase
  alias Cookbook.Scraper.HelloFresh

  describe "scrape/3" do
    test "can scrape recipes from a HelloFresh menu endpoint" do
      meal_list = HelloFresh.scrape(2019, 48, File.read!("test/fixtures/hello_fresh.html"))

      assert meal_list == [
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/5da0c873ccb8725fb11c406e-efcacfa2.jpg",
                 name: "Pork Carnitas Tacos"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/pasta-parmesan-edc4e3e8.jpg",
                 name: "Pasta Parmesan"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/amazing-apricot-chicken-0b388ccc.jpg",
                 name: "Amazing Apricot Chicken"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/5da0c84c2316237d066314c2-e01f5093.jpg",
                 name: "Beef Bulgogi Bowls"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/mediterranean-beef-kofta-patties-6dbe7c0b.jpg",
                 name: "Mediterranean Beef Kofta Patties"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/5da0ca1854a3a24e1d4c0b8b-5eb401a1.jpg",
                 name: "Double Cheese & Pork Sausage Flatbreads"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/5da0ca4a5952785d4608877b-3211c2da.jpg",
                 name: "Chicken Teriyaki Bowls"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/honey-sriracha-pork-tenderloin-59ba0fcd.jpg",
                 name: "Honey Sriracha Pork Tenderloin"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/sweet-potato-and-cranberry-farro-bowl-a62b7173.jpg",
                 name: "Roasted Veggie Farro Bowls"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/5da0cbf490251003c01f40cc-f8d0efac.jpg",
                 name: "Southwest Stuffed Poblanos"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/lemon-butter-trout-6c1631c9.jpg",
                 name: "Lemon Butter Sockeye Salmon"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/5da0cc56de1b3b72b45de266-2dc20199.jpg",
                 name: "Mozzarella-Stuffed Little Italy Burgers"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/blackened-tilapia-tacos-d3e788c2.jpg",
                 name: "Blackened Tilapia Tacos"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/5da0cd276d059e10d17da2f4-5fac3921.jpg",
                 name: "Classic Spaghetti and Meatballs"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/sticky-honey-dijon-chicken-legs-8b52abfa.jpg",
                 name: "Sticky Honey-Dijon Chicken Legs"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/5da0cdb7941ee840c27ac7c0-287f8cf6.jpg",
                 name: "Sirloin Steak Provençal"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/shrimp-pasta-with-a-kick-be5e60d6.jpg",
                 name: "Shrimp Spaghetti with a Kick"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/5da0ce5699a94b3a8d4f5b07-5ce05c01.jpg",
                 name: "Chicken Sausage and Spinach Ravioli"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/el-paso-pork-burgers-90068123.jpg",
                 name: "El Paso Pork Burgers"
               },
               %{
                 img_url:
                   "https://img.hellofresh.com/hellofresh_s3/image/veggie-tacos-al-pastor-0954d423.jpg",
                 name: "Veggie Tacos Al Pastor"
               }
             ]
    end
  end
end
