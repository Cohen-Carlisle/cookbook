defmodule Cookbook.Scraper.HelloFreshTest do
  use Cookbook.DataCase
  alias Cookbook.Scraper.HelloFresh

  test "can scrape recipes from a HelloFresh menu endpoint" do
    actual = HelloFresh.scrape(2019, 48, File.read!("test/fixtures/hello_fresh.html"))

    expected = [
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/5da0c873ccb8725fb11c406e-efcacfa2.jpg",
        name: "Pork Carnitas Tacos with Pickled Onion and Monterey Jack Cheese",
        note: "Family friendly",
        time: 35
      },
      %{
        img_url: "https://img.hellofresh.com/hellofresh_s3/image/pasta-parmesan-edc4e3e8.jpg",
        name: "Pasta Parmesan with Zucchini, Tuscan Herbs, and Marinara Sauce",
        note: "Veggie",
        time: 35
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/amazing-apricot-chicken-0b388ccc.jpg",
        name: "Amazing Apricot Chicken with Roasted Potatoes and Green Beans",
        note: "570 calories",
        time: 35
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/5da0c84c2316237d066314c2-e01f5093.jpg",
        name:
          "Beef Bulgogi Bowls with Carrots, Pickled Cucumber, and Sriracha Crema over Jasmine Rice",
        note: "Family friendly",
        time: 20
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/mediterranean-beef-kofta-patties-6dbe7c0b.jpg",
        name:
          "Mediterranean Beef Kofta Patties with Garlic-Lemon Aioli and Roasted Veggie Jumble",
        note: nil,
        time: 40
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/5da0ca1854a3a24e1d4c0b8b-5eb401a1.jpg",
        name: "Double Cheese & Pork Sausage Flatbreads with Roasted Long Green Pepper and Onion",
        note: "Family friendly",
        time: 30
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/5da0ca4a5952785d4608877b-3211c2da.jpg",
        name: "Chicken Teriyaki Bowls with Bell Pepper, Peanuts, and Sriracha",
        note: nil,
        time: 40
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/honey-sriracha-pork-tenderloin-59ba0fcd.jpg",
        name: "Honey Sriracha Pork Tenderloin with Roasted Sesame Carrots and Cilantro-Lime Rice",
        note: nil,
        time: 45
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/sweet-potato-and-cranberry-farro-bowl-a62b7173.jpg",
        name:
          "Roasted Veggie Farro Bowls with Marinated Cranberries and Salsa Verde Sunflower Pepitas",
        note: "Veggie",
        time: 40
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/5da0cbf490251003c01f40cc-f8d0efac.jpg",
        name: "Southwest Stuffed Poblanos with Quinoa and Corn",
        note: "570 calories",
        time: 35
      },
      %{
        img_url: "https://img.hellofresh.com/hellofresh_s3/image/lemon-butter-trout-6c1631c9.jpg",
        name: "Lemon Butter Sockeye Salmon with Asparagus Amandine and Horseradish Potato Mash",
        note: nil,
        time: 30
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/5da0cc56de1b3b72b45de266-2dc20199.jpg",
        name:
          "Mozzarella-Stuffed Little Italy Burgers with Griddled Tomato, Patate al Forno, and Arugula Salad",
        note: nil,
        time: 30
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/blackened-tilapia-tacos-d3e788c2.jpg",
        name: "Blackened Tilapia Tacos with Pineapple Salsa and Red Cabbage Slaw",
        note: nil,
        time: 30
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/5da0cd276d059e10d17da2f4-5fac3921.jpg",
        name: "Classic Spaghetti and Meatballs with Zucchini and Parmesan",
        note: nil,
        time: 50
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/sticky-honey-dijon-chicken-legs-8b52abfa.jpg",
        name: "Sticky Honey-Dijon Chicken Legs with Garlic Mashed Potatoes and Lemony Broccoli",
        note: "710 calories",
        time: 45
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/5da0cdb7941ee840c27ac7c0-287f8cf6.jpg",
        name: "Sirloin Steak Provençal with Truffle Cream, Roasted Carrots, and Potatoes",
        note: nil,
        time: 45
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/shrimp-pasta-with-a-kick-be5e60d6.jpg",
        name: "Shrimp Spaghetti with a Kick with Garlic Herb Butter and Zucchini",
        note: "740 calories",
        time: 20
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/5da0ce5699a94b3a8d4f5b07-5ce05c01.jpg",
        name: "Chicken Sausage and Spinach Ravioli with Tomato and Lemon",
        note: nil,
        time: 20
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/el-paso-pork-burgers-90068123.jpg",
        name: "El Paso Pork Burgers stuffed with Monterey Jack and served with Potato Wedges",
        note: "Spicy",
        time: 35
      },
      %{
        img_url:
          "https://img.hellofresh.com/hellofresh_s3/image/veggie-tacos-al-pastor-0954d423.jpg",
        name: "Veggie Tacos Al Pastor with Warm Pineapple Salsa and Pickled Veggies",
        note: "Veggie",
        time: 35
      }
    ]

    assert actual == expected
  end
end
