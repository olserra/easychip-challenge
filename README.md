# Ruby Exercise Guidelines

- Fork the repo
- Clone it
- Run `rake db:seed` (Optional - You can populate your own DB)

# General Advice

- **Bugs**: All developers make mistakes, so there may be some bugs in our app. If something seems abnormal, it's probably because one of our developers made a mistake. Read the code carefully, fix any bugs you find and feel free to suggest changes to make the code cleaner.
- **Git Workflow** : At Easyship, we use the Git workflow every day, so it's vital that you learn to use it from the very beginning. Each of the following tasks represent an individual feature. For each feature, we recommend that you create a new branch, either off `master` or another branch that you believe is more appropriate, and create a pull request when you are done.

# Tasks

## Task 1

The front end needs to display the items included in a shipment. The problem is, we often have items that are the same and the front end needs them regrouped. Write a function for `Shipment` that groups its associated `ShipmentItem`s by description and returns an array of hashes. The hashes should be ordered by count, in descending order.

If your `Shipment` contains the following `ShipmentItem`s: 2 iPhones, 3 iPads and 1 Apple Watch. The function should return:

```ruby
[
  { description: 'iPad', count: 3 },
  { description: 'iPhone', count: 2 },
  { description: 'Apple Watch', count: 1 }
]
```

Before this goes live, we want to make sure there are no bugs. Could you also write some tests using RSpec (`shipment_spec.rb`) to make sure the method works correctly?

## Task 2

Now let's implement a GET `companies/:id/shipments/:id` endpoint to retrieve data on a specific shipment. The response should look like this:

```json
{
  "shipment": {
    "company_id": "64b5d8b2-4c11-4faf-bf1b-9f7b1b7ca1c8",
    "destination_country": "USA",
    "origin_country": "HKG",
    "tracking_number": "UM459056399US",
    "slug": "usps",
    "created_at": "Monday, 15 August 2017 at 2:30 PM",
    "items": [
      { "description": "iPad", "count": 3 },
      { "description": "iPhone", "count": 2 },
      { "description": "Apple Watch", "count": 1 }
    ]
  }
}
```

## Task 3

Our clients want to see where their shipments are, so let's update that endpoint to return tracking information as well. We use the Aftership API (https://www.aftership.com/docs/api/4/overview) to retrieve tracking data for our shipments. Make a request to the Aftership API to retrieve the information you need and update the response accordingly:

```json
{
  "shipment": {
    "company_id": "64b5d8b2-4c11-4faf-bf1b-9f7b1b7ca1c8",
    "destination_country": "USA",
    "origin_country": "HKG",
    "tracking_number": "UM459056399US",
    "slug": "usps",
    "created_at": "Monday, 15 August 2017 at 2:30 PM",
    "tracking": {
      "status": "InTransit",
      "current_location": "ISC NEW YORK NY(USPS)",
      "last_checkpoint_message": "Processed Through Facility",
      "last_checkpoint_time": "Friday, 21 July 2017 at 8:55 PM"
    }
  }
}
```

Use the following API key: `711623ab-a860-4d3a-84d1-bfa891ff5058` to make the request.

Don't forget to account for when no tracking information is available yet! What should be returned in those cases?

## Task 4

We have an endpoint (GET `/companies/:id/shipments/`) to retrieve some information about the shipments but it does not quite do what it's supposed to! It's retrieving ALL the shipments! Even those that do not belong to the company in the URL. Could you have a look and make sure that only the shipments that belong to the company are included.

In addition, we've heard of some built-in Rails functions that we can implement to improve on our code:

- Looking at our logs, it seems that we make a query the DB to retrieve each `ShipmentItem` individually. We've read about the `includes` method and we think it could help us. Could you try to implement it? [documentation](https://apidock.com/rails/ActiveRecord/QueryMethods/includes)
- **BONUS** When we retrieve the `company.name` to include in the json, the way we do it introduces some `structural coupling` (an object should not call a method on another object from the view), the CTO has suggested using the `delegate` function to avoid this. [documentation](https://apidock.com/rails/Module/delegate)

