---
title: API Reference

language_tabs:
  - shell
  - javascript

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='http://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true
---

# Introduction

Shippify is a SAAS for logistics using crowdsourced verified community of shippers to provide  a 24 hour delivery solution to e-commerce stores, retailers, supermarkets and small businesses.

Welcome to the Shippify API! You can use our API to access Shippify API endpoints, which can allow the creation and dispatching of real time deliveries and manage logistics for your e-commerce or online store.

We have language bindings in Shell for now. You can view code examples in the dark area to the right, and in the future you will be able to switch the programming language of the examples with the tabs in the top right.



# Authentication

> To authorize, use basic AUTH:


```shell
# With shell, you can just pass the correct header with each request

curl -X POST "api_endpoint_here"
  -u "<apiKeyId>:<apiSecretId>"
```

> Make sure to replace `<apiKeyId>` with your API key and <apiSecretId> with the Api secret Id.

Shippify uses API keys to allow access to the API. You can check and get a new API key pair signing in your account [admin portal](https://services.shippify.co/settings).

Shippify expects for the API key to be included in all API requests to the server in a header that looks like the following:

`Authorization: "Basic <apiKeyId>:<apiSecretId>" `


<aside class="notice">
You can use the testing api keys for BASIC HTTP Authentication 
<code>"api_id" : "i7p0cengnryk96fzip9442t9"</code> 
<code>"api_secret_token": "bf77573b25ef44da893fb30d890af78f"</code> 
</aside>

# Tasks


## Create a task


```javascript

function newTask() {
  
  var formJsonObj = form2js(document.getElementById('formPost'));
  var postObject = {task: formJsonObj};

  $.ajax({
    type: 'POST',
    url: '/task/new',
    dataType: 'json',
    data: postObject,
    beforeSend: function(xhr) {
      xhr.setRequestHeader("Authorization", "Basic " + btoa(api_id + ":" + api_token));
    },
    success: function(response, textStatus, jqXHR) {
     
        console.log("Success response and validate JSON" + JSON.stringify(response));
      
    },
    error: function(jqXHR, exception) {
      console.log("Error en envio de Datos" + exception);
    }
  });
} 

```

```shell
curl -X POST 'https://services.shippify.co/task/new'
  -u '<apiKeyId>:<apiSecretId>'
  -d 'task[products][0][id]=my_inventory_product_id' 
  -d 'task[products][0][name]=Glass' 
  -d 'task[products][0][size]=1' 
  -d 'task[products][0][qty]=4' 
  -d 'task[sender][email]=luis@shippify.co' 
  -d 'task[recipient][email]=miguel@shippify.co' 
  -d 'task[pickup][address]=Rua Doutor Sette Câmara, Luxemburgo' 
  -d 'task[pickup][lat]=-19.9430687' 
  -d 'task[pickup[lng]=-43.95513460000001' 
  -d 'deliver[address]=Rua Curitiba 1957, Lourdes' 
  -d 'deliver[lat]=-19.9298613' 
  -d 'deliver[lng]=-43.94431470000001' 
  -d 'task[extra]= {\"note\":\"Perto do Seed\",\"troco\":\"$20\"}'
```

> The above command returns JSON structured like this:

```json
{
"errFlag":    0,
"id":     "task_id",
"price":  "currency_price",
"distance": "distance_in_km",
“city” : “city_short_name”,
“currencySign”:”example_CLP”
}

```

This endpoint creates a new task in the system that will show up to a nearest shipper to the pickup point.

### HTTP Request

`POST https://services.shippify.co/task/new`

### Query Parameters

Parameter | Description
--------- | -----------
products[0][id] | Identifier in your stock of 0 product
products[0][name] | name of 0 product
products[0][qty] | quantity of 0 product, how many of this product.
products[0][size] | size of 0 product
products[1...n][name] | name of n product (optional)
products[1...n][qty] | quantity of n product, how many of this product.(optional)
products[1...n][size] | size of n product (optional)
recipient[name] | (optional) name of user who receives the shipping
recipient[email] | email of user who receives the shipping
recipient[phone] | (optional) Phone number of user who receives the shipping
sender[name] | (optional) Name of user who sends the shipping
sender[email] | email of user who sends the shipping
sender[phone] | (optional) Phone number of user who sends the shipping
pickup[address] | address from pickup location
pickup[lat] | latitude from pickup location
pickup[lng] | longitude from pickup location
deliver[address] | address from delivery from pickup location location
deliver[lat] | latitude from delivery location
deliver[lng] | longitude from delivery location
extra | JSON as a string for extra params given by the developer for their own use. For example: extra: `‘{\"note\":\"Perto do Seed\",\"troco\":\"$20\"}'`
payment_type | (optional) Payment types must be specified for credit, debit or bank transfer. By default is credit. Check the payment status integers to send.
payment_status | (optional) Specify the payment  status of this task, if it is already paid by the client through your platform then this task will be reconciled at the end of the month.
total_amount | (optional) Is the total amount of money the shipper needs to charge in cash, if the recipient did not payed before with bank transfer or credit card online.
delivery_date | (optional) If you want to schedule a task for a date in the future you can specify a delivery date. This parameter must be a UNIX TIMESTAMP.


<aside class="notice">
When developers and companies add warehouses in the shippify panel, you can use those warehouses to create a new task, specifying warehouses ids as your delivery or pickup locations.
</aside>

For example:

 Parameter | Description
--------- | -----------
deliver[warehouse] | warehouse ID.
pickup[warehouse] | warehouse ID.
 


## Get a Task


```shell
curl "https://services.shippify.co/task/info/:idtask"
  -H "Authorization: meowmeowmeow"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 1,
    "name": "Fluffums",
    "breed": "calico",
    "fluffiness": 6,
    "cuteness": 7
  },
  {
    "id": 2,
    "name": "Isis",
    "breed": "unknown",
    "fluffiness": 5,
    "cuteness": 10
  }
]
```

This endpoint retrieves all kittens.

### HTTP Request

`GET http://example.com/api/kittens`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
include_cats | false | If set to true, the result will also include cats.
available | true | If set to false, the result will include kittens that have already been adopted.

<aside class="success">
Remember — a happy kitten is an authenticated kitten!
</aside>

## Get a Specific Kitten

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.get(2)
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
api.kittens.get(2)
```

```shell
curl "http://example.com/api/kittens/2"
  -H "Authorization: meowmeowmeow"
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "name": "Isis",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

This endpoint retrieves a specific kitten.

<aside class="warning">If you're not using an administrator API key, note that some kittens will return 403 Forbidden if they are hidden for admins only.</aside>

### HTTP Request

`GET http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the kitten to retrieve

