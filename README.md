# Welcome

This repository contains starter code for a technical assessment. The challenges can be done at home before coming in to discuss with the Bark team or can be done as a pairing exercise at the Bark office. Either way, we don't expect you to put more than an hour or two into coding. We recommend forking the repository and getting it running before starting the challenge if you choose the pairing approach.

# Set up

Fork this repository and clone locally

You'll need [ruby 2.2.4](https://rvm.io/rvm/install) and [rails 5](http://guides.rubyonrails.org/getting_started.html#installing-rails) installed.

Run `bundle install`

Initialize the data with `rake db:reset`

Run the specs with `rspec`

Run the server with `rails s`

View the site at http://localhost:3000

# Code Challenge Notes

1. Add pagination
- Added kaminari gem (Chose over will_paginate)

2. Multiple Uploads
- Assuming this means selecting multiple files in the file window at once, and not grouping uploads in some way
- Already a feature in simple_form
  - Added: `input_html: { multiple: 'multiple' }`
- Would want to do more research on how that’s implemented, and if its a security concern
- Possible to implement with custom inputs / custom form?

3. Associate dog with user
- Added an ActiveRecord migration to add owner column to Dog
- ActiveRecord associations in models - belongs_to optional:true in Dog and has_many in User
- Add owner id to newly created dog

4. Allow editing only by owner
- Validation for update method
- Conditionally render edit/delete buttons in views only when owner
- To improve: maybe refactor some of the logic into a helper method

5. Add likes; Users can only like other user’s dogs;
- Add migration for adding a new table
- Create new Likes model and add associations to both user and dog
- Add /like routes
- Add like controller with create and destroy
- Update show view to display total likes and a button for like /unlike

-  Considered using acts_as_votable gem
-  Should be “like” instead of “likes” when 1

6. Allow sorting the index page by number of likes in the last hour
- Added a computed property for recent likes in dog model, but ended up sorting by likes via a query
- pass in a param to sort by default or by popular

Known issues:
- Should sort by likes within past hour but instead doing total likes
- Should still display all other dogs (Eg. with 0 likes in the past hour) in default order after
- Update button to “sort by default” (currently have to click on “Dog Profile Demo”)

7. Display the ad.jpg image (saved at app/assets/images/ad.jpg) after every 2 dogs in the index page, to simulate advertisements in a feed.
- Added the ad image after every even number id dog, which doesn’t work when sorting by popular
- Possible Solution: Go back and reimplement pagination manually, and pass in “pages” of dogs to view, with ad images at specific intervals (dog, dog, ad, dog, dog, ad, dog) for every page.

Potential tests to add:
Note: Would need to add Devise test helpers to test user relating logic
- A user can’t like the same dog twice (without unliking)
- A user can’t like their own dog
- User can’t edit someone else’s dog
