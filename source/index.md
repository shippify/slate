---
title: Shippify API Reference

language_tabs:
  - shell
  - javascript

toc_footers:
  - <a href='http://shippify.co'>Check our services</a>
  - <a href='https://services.shippify.co/company/signup'>Sign Up for a Developer Key</a>
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
</aside>

 Api Key Id | Api Secret Id
--------- | -----------
"i7p0cengnryk96fzip9442t9" | "bf77573b25ef44da893fb30d890af78f"

 


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
  -d 'task[pickup][lng]=-43.95513460000001' 
  -d 'task[deliver][address]=Rua Curitiba 1957, Lourdes' 
  -d 'task[deliver][lat]=-19.9298613' 
  -d 'task[deliver][lng]=-43.94431470000001' 
  -d 'task[extra]= {\"note\":\"Perto do Seed\",\"troco\":\"$20\"}'
```

> The above command returns JSON structured like this:

```json
{
"errFlag":    0,
"id":     "task_id",
"price":  "currency_price",
"distance": "distance_in_km",
"city" : "city_short_name",
"currencySign":"example_CLP"
}

```

This endpoint creates a new task in the system that will show up to a nearest shipper to the pickup point.

### HTTP Request

`POST https://services.shippify.co/task/new`

### Query Parameters

Parameter | Description
--------- | -----------
task[products][0][id] | Identifier in your stock of 0 product
task[products][0][name] | name of 0 product
task[products][0][qty] | quantity of 0 product, how many of this product.
task[products][0][size] | size of 0 product
task[products][1...n][name] | name of n product (optional)
task[products][1...n][qty] | quantity of n product, how many of this product.(optional)
task[products][1...n][size] | size of n product (optional)
task[recipient][name] | (optional) name of user who receives the shipping
task[recipient][email] | email of user who receives the shipping
task[recipient][phone] | (optional) Phone number of user who receives the shipping
task[sender][name] | (optional) Name of user who sends the shipping
task[sender][email] | email of user who sends the shipping
task[sender][phone] | (optional) Phone number of user who sends the shipping
task[pickup][address] | address from pickup location
task[pickup][lat] | latitude from pickup location
task[pickup][lng] | longitude from pickup location
task[deliver][address] | address from delivery from pickup location location
task[deliver][lat] | latitude from delivery location
task[deliver][lng] | longitude from delivery location
task[extra] | JSON as a string for extra params given by the developer for their own use. For example: extra: `‘{\"note\":\"Perto do Seed\",\"troco\":\"$20\"}'`
task[payment_type] | (optional) Payment types must be specified for credit, debit or bank transfer. By default is credit. Check the payment status integers to send.
task[payment_status] | (optional) Specify the payment  status of this task, if it is already paid by the client through your platform then this task will be reconciled at the end of the month.
task[total_amount] | (optional) Is the total amount of money the shipper needs to charge in cash, if the recipient did not payed before with bank transfer or credit card online.
task[delivery_date] | (optional) If you want to schedule a task for a date in the future you can specify a delivery date. This parameter must be a UNIX TIMESTAMP.
task[send_email_params]  | (optional) If you want to send an email to the recipient. This is a JSON string. Some companies can have or customize email templates to send a custom email to their users every time a task is created. For example: send_email_params: `‘{\"from\":\"Custom from email name or company name \",\"subject\":\"Custom subject for your email\"}'`


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
curl -X GET 'https://services.shippify.co/info/:idtask'
  -u '<apiKeyId>:<apiSecretId>'
```

> The above command returns JSON structured like this:

```json
{
  "errFlag": 0,
  "data": {
    "items": [
      {
        "id": "0",
        "name": "N Menor",
        "qty": "1",
        "size": "2"
      },
      {
        "id": "0",
        "name": "N Menor",
        "qty": "1",
        "size": "2"
      }
    ],
    "date": "2015-07-03T21:38:14.000Z",
    "sender": {
      "email": "chinaloa.ts@gmail.com"
    },
    "receiver": {
      "_id": "55761144dacec286b0aa8a55",
      "id_ref": "Riacho das Pedras",
      "name": "Riacho Doce",
      "email": null,
      "phonenumber": null,
      "company": "85",
      "address": "{\"address\":\"R. Corcovado, 572 - Monte Castelo, Contagem - MG, Brazil\",\"lat\":\"-19.9441765\",\"lng\":\"-44.066946299999984\",\"city\":\"Contagem\",\"country\":\"BR\"}"
    },
    "pickup_location": {
      "address": "Rua Guilherme Ciriene, 367, Jardim Industrial, Minas Gerais, Brasil",
      "lat": "-19.9647343",
      "lng": "-44.02099750000002"
    },
    "delivery_location": {
      "address": "R. Corcovado, 572 - Monte Castelo, Contagem - MG, Brazil",
      "lat": "-19.9441765",
      "lng": "-44.066946299999984"
    },
    "state": 0,
    "type": 1,
    "price": 4,
    "distance": 5.32,
    "shipper_id": null,
    "total_size": 5,
    "payment_status": 1,
    "city": 1,
    "delivery_dt": null,
    "return_id": null,
    "total_amount": 189,
    "route_id": null,
    "shipper_firstname": null,
    "shipper_lastname": null,
    "shipper_email": null,
    "tid": "ibo57hd0px8ncdi",
    "extra": {
      "note": "Riacho das Pedras"
    }
  }
}
```

This endpoint retrieves an specific task.

### HTTP Request

`GET https://services.shippify.co/task/info/:taskId`

### Query Parameters

Parameter | Description
--------- | -----------
taskId | The id of the task to get info


### Response attributes detail


Attribute | Variable name | Description
--------- | ---------------- | -----------
Total Amount | total_amount | Is the total amount of money that the shipper will charge the client.
Price         | price | Is the shipping price, and what the shipper is going to charge Shippify to do the shipping.
 

## Fare


```shell
curl -X GET 'https://services.shippify.co/task/fare'
  -u '<apiKeyId>:<apiSecretId>'
```

> The above command returns JSON structured like this:

```json
{
    "errFlag": 0,
    "price": "18.55",
    "distance": 2.9655261209905985,
    "currency": "BRL",
    "city": {
        "id": 1,
        "name": "Belo Horizonte",
        "country": "BRASIL",
        "lat": -19.9245,
        "lng": -43.9353,
        "short": "BH",
        "lang": "pr"
    }
}
``` 

Get the price of the fare based on the pickup and delivery locations, used mostly by the widgets or components created by developers in the anticipation of purchase at order placement in e-commerce sites.

We are changing this endpoint to support multiple taks and routes


### HTTP Request

`GET https://services.shippify.co/task/fare`

### Query Parameters

| Parameter | Value      | Description
| --------- | ------------| -----------
| data      | `{ "pickup": { "lat": 0,"lng": 0 },"deliver": {"lat": 0,"lng": 0 } }` | JSON of pickup and delivery location values 


### CALCULATIONS

All task are calculated based in variables set by city. Every city has different fares values that are calculated based on distance (KM) and total size.

`http://services.shippify.co/fares`


<aside class="notice">
This endpoint will be moved to a FARE entity section, not below TASK entity section like now.
</aside>


## Status

Sepecification of status that a task can have. The status of a task is determined by an integer. The possible values are:



### Status Details

Status | Description
------ | -----------
0 | Cancelled - The Task was canceled by the administrator
1 | Getting ready -  The task is created but need to define the recipient or receiver.
2 | Pending to assign -  The task has not been assigned to any worker/shipper
3 | Pending for shipper response - The task was assigned by the admin and needs to be accepted by the assigned shipper.
4 | Shipper confirmed  - The task has a shipper already confirmed by him to do the task. Starts the journey to the pickup location.
5 | Being picked up - Shipper arrived to the pickup location. The task has being picked up by a worker/shipper.  Now Shipper begins journey to 
6 | Being delivered -  Shipper begun the journey from the pickup location to the destination.
7 | Delivered successfully -   Shipper dropped off the product(s) at the drop off /delivered location of the task. The system admin or receiver confirmed the task was completed.



### Scenarios

* In the state of 3 If a Shipper decline the assignation of a task, the task state goes back to 2.
* In the state of 4 If a Shipper have a problem picking up the items of task and decides to abandon the trip the task state goes back to 2.
* The administrator can only cancel a task if the task is not yet assigned with a confirmed shipper.


<aside class="warning">
Statuses can change in the future, especially because status 5: picking up the products could be divided in 2 where you have picking up and picked up.
</aside>




## Payment Types

Currently payment types of a task can be 5.


Type number | Description
------ | -----------
1 | Credit - pay with credit card
2 | Cash - pay in cash
3 | Bank transfer - Pay in a bank transfer
4 | Debit - Pay with debit card
5 | Boleto - Pay with boleto (brasil)


## Payment STATUS

The payment status can change from paid to not paid.

Status number | Description
------ | -----------
1 | Not paid 
2 | Paid

## Sizes


All tasks have a “total_size” (total size) that matches with a shipper that can handle that type of size. The total size of a task is calculated by the sum of all the product sizes on the task. The supported sizes are:


Size id | Description
------ | -----------
1 | Extra Small (XS) - Keys, papers, documents.
2 | Small (S) -  Tedy Bears, Shoe’s box, keyboard, Ipad.
3 | Medium (M)-  Laptop, PC, monitor.
4 | Large (L)- Chair, a small desk, bicycle.
5 | Extra large (XL) - Desk, furniture, boat.



# Warehouses

The warehouses API’s allows companies to set locations that they currently use for pickup or delivery.  


## List


```shell
curl -X GET 'https://services.shippify.co/warehouse/list'
  -u '<apiKeyId>:<apiSecretId>'
```

> The above command returns JSON structured like this:

```json
{
    "errFlag": 0,
    "warehouses": [
        {
            "id": 29,
            "name": "Av Quito",
            "id_company": 2,
            "location": "{\"address\":\"Avenida Quito, Guayaquil, Guayas, Ecuador\",\"lat\":\"-2.19761\",\"lng\":\"-79.8917601\",\"country\":\"EC\"}",
            "lat": -2.19761,
            "lng": -79.8918
        },
        {
            "id": 32,
            "name": "Alborada V Etapa",
            "id_company": 2,
            "location": "{\"address\":\"Alborada V, Guayaquil, Guayas, Ecuador\",\"lat\":\"-2.1365745\",\"lng\":\"-79.89618000000002\",\"country\":\"EC\"}",
            "lat": -2.13657,
            "lng": -79.8962
        }  
    ]
}
```

This endpoint retrieves an specific task.

### HTTP Request

`GET https://services.shippify.co/task/info/:taskId`

### Query Parameters

Parameter | Description
--------- | -----------
taskId | The id of the task to get info


### Response attributes detail


Attribute | Variable name | Description
--------- | ---------------- | -----------
Total Amount | total_amount | Is the total amount of money that the shipper will charge the client.
Price         | price | Is the shipping price, and what the shipper is going to charge Shippify to do the shipping.


# Routes

Routes will cluster tasks and create a more efficient fare for all those tasks. The route can be assigned to a shipper so he can do the delivery of multiple tasks.

Routes that we currently support are:

* Common pickup location 
This routes are a group of task that have common pickup locations and different delivery locations.




# Widgets


Widgets allow companies to create, calculate and query tasks with a user interface provided by Shippify that can be customized with the look and feel of any UI.


Get an HTML embedded component from the company of the user. A list of all registered warehouses


The widget is initialized with some variables that will be documented soon.







