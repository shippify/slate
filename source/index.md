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

Shippify uses API keys to allow access to the API. You can get an API key pair signing in your account at [admin portal](https://services.shippify.co/settings).

Shippify expects for the API key to be included in all API requests to the server in a header that looks like the following:

`Authorization: "Basic <apiKeyId>:<apiSecretId>" `


# Tasks


## Create a task


```javascript
var data = {
  task: {
    products: [
      {
        id: 'my_inventory_product_id',
        name: 'Glass',
        size: 1,
        qty: 4
      }
    ],
    sender: {
      email: 'luis@shippify.co'
    },
    recipient: {
      email: 'miguel@shippify.co'
    },
    pickup: {
      address: 'Rua Doutor Sette Câmara, Luxemburgo',
      lat: -19.9430687,
      lng: -43.95513460000001
    },
    deliver: {
      address: 'Rua Curitiba 1957, Lourdes',
      lat: -19.9298613,
      lng: -43.94431470000001
    },
    extra: '{"note":"In front of a green building with red roof","change":"$20"}'
  }
};

$.ajax({
  type: 'POST',
  url: '/task/new',
  dataType: 'json',
  data: data,
  beforeSend: function (xhr) {
    xhr.setRequestHeader("Authorization", "Basic " + btoa(<apiKeyId> + ":" + <apiSecretId>));
  },
  success: function (response, textStatus, jqXHR) {
    console.log("Success response and validate JSON" + JSON.stringify(response));
  },
  error: function (jqXHR, exception) {
    console.log("Error en envio de Datos" + exception);
  }
});
```

```shell
curl -X POST 'https://services.shippify.co/task/new'
  -H 'Accept-Charset: utf-8'
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
  -d 'task[extra]={"note":"In front of a green building with red roof","change":"$20"}'
```

> The above command returns JSON structured like this:

```json
{
  "id": "t-shieam-92",
  "price": "9.90",
  "distance": 2.957,
  "currencySign": "R$"
}
```

Create a new task in the system. The task will be assigned to a shipper when it's delivery date gets close.

### HTTP Request

`POST https://services.shippify.co/task/new`

### Query Parameters

Parameter | Description
--------- | -----------
task.products | List of 1 or more Product objects
task.recipient | Customer object for the receiving party (optional)
task.sender | Customer object for the emitting party (optional)
task.pickup | Location of object for pickup
task.deliver | Location of object for delivery
task.extra | JSON string for additional data given by the developer for their own use. For example: extra: `‘{"note":"In front of a green building with red roof","change":"$20"}'`
task.payment_type | Payment types must be specified for credit, debit or bank transfer (optional). Defaults to Credit(1)
task.payment_status | Specify the payment status of this task, if it is already paid by the client through your platform then this task will be reconciled at the end of the month (optional)
task.total_amount | The total amount charged by the shipper in cash, if the recipient did not pay before via bank transfer or credit card online (optional)
task.delivery_date | Delivery date for a future scheduled task. This parameter must be a UNIX TIMESTAMP (optional)
task.send_email_params  | (optional) If you want to send an email to the recipient. This is a JSON string. Some companies can have or customize email templates to send a custom email to their users every time a task is created. For example: send_email_params: `‘{\"from\":\"Custom from email name or company name \",\"subject\":\"Custom subject for your email\"}'`

### Product Object

Parameter | Description
--------- | -----------
id | Identifier in your client's stock of the product
name | Name of the product
qty | Quantity of items of the product
size | Size of the product

### Customer Object

Parameter | Description
--------- | -----------
name | Name of the customer
email | Email of the customer
phone | Phone number of the customer

### Location Object

Parameter | Description
--------- | -----------
address | Location's physical address
lat | Location's latitude
lng | Location's longitude


<aside class="notice">
When developers and companies add warehouses in the shippify panel, you can use those warehouses to create a new task, specifying warehouses ids as your delivery or pickup locations.
</aside>

For example:

 Parameter | Description
--------- | -----------
deliver[warehouse] | warehouse ID.
pickup[warehouse] | warehouse ID.
 


## Get a Task

```javascript
$.ajax({
  type: 'GET',
  url: '/task/info/:taskId',
  beforeSend: function (xhr) {
    xhr.setRequestHeader("Authorization", "Basic " + btoa(<apiKeyId> + ":" + <apiSecretId>));
  },
  success: function (response, textStatus, jqXHR) {
    console.log("Success response and validate JSON" + JSON.stringify(response));
  },
  error: function (jqXHR, exception) {
    console.log("Error en envio de Datos" + exception);
  }
});
```

```shell
curl -X GET 'https://services.shippify.co/task/info/:taskId'
  -u '<apiKeyId>:<apiSecretId>'
```

> The above command returns JSON structured like this:

```json
{
  "errFlag": 0,
  "errMsg": "Success",
  "data": {
    "tid": "ibo57hd0px8ncdi",
    "products": [
      {
        "id": "0",
        "name": "42286",
        "qty": 1,
        "size": 3,
        "price": "0"
      }
    ],
    "addr1": "Rua Guilherme Ciriene, 367, Jardim Industrial, Minas Gerais, Brasil",
    "dropAddr1": "R. Corcovado, 572 - Monte Castelo, Contagem - MG, Brazil",
    "amount": 189,
    "price": 4,
    "city": 1,
    "pickLat": "-19.9647343",
    "pickLong": "-44.02099750000002",
    "dropLat": "-19.9441765",
    "dropLong": "-44.066946299999984",
    "date": "2015-07-03T21:38:14.000Z",
    "delivery_date": "0000-00-00 00:00:00",
    "sender": "chinaloa.ts@gmail.com",
    "recipient": "55761144dacec286b0aa8a55",
    "totalSize": 5,
    "status": 0,
    "payStatus": 1,
    "payType": 1,
    "distance": 5.32,
    "shipper": null,
    "route": null,
    "sign": "R$",
    "recipientData": "{\"email\":\"55761144dacec286b0aa8a55\",\"name\":\"55761144dacec286b0aa8a55\"}",
    "extra": "{\"note\":\"Riacho das Pedras\"}"
  }
}
```

Fetch a specific task based on the id provided if it exists.

### HTTP Request

`GET https://services.shippify.co/task/info/:taskId`

### Query Parameters

Parameter | Description
--------- | -----------
taskId | The id of the task to get info


### Response attributes detail


Attribute | Variable name | Description
--------- | ---------------- | -----------
Total Amount | total_amount | The total amount of money that the shipper will charge the client
Price | price | The shipping price, and what the shipper is going to charge Shippify to do the shipping
Creation Date | date | The date in which the task was created
Task State | state | Current state in shipping flow of the task
Shipper Id | shipper_id | Current shipper assigned to handle task if any
Route | route_id | Current route the task belongs to if any
 

## Fare

```javascript
var data = {
  data: {
    pickup_location: {
      lat: -2.19761,
      lng: -79.8917601
    },
    delivery_location: {
      lat: -2.141976,
      lng: -79.86730899999998
    },
    items: [
      {
        id: "10234",
        name: "TV",
        qty: 2,
        size: 3
      }
    ]
  }
};

$.ajax({
  type: 'GET',
  url: '/task/fare',
  data: data,
  beforeSend: function (xhr) {
    xhr.setRequestHeader("Authorization", "Basic " + btoa(<apiKeyId> + ":" + <apiSecretId>));
  },
  success: function (response, textStatus, jqXHR) {
    console.log("Success response and validate JSON" + JSON.stringify(response));
  },
  error: function (jqXHR, exception) {
    console.log("Error en envio de Datos" + exception);
  }
});
```


```shell
curl -X GET 'https://services.shippify.co/task/fare?data=[{"pickup_location":{"lat":-2.19761,"lng":-79.8917601},"delivery_location":{"lat":-2.141976,"lng":-79.86730899999998},"items":[{"id":"10234","name":"TV","qty":"2","size":"3","price":"0"}]}]'
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
| data.pickup_location | { lat, lng } | Latitude and longitude object for pickup
| data.delivery_location | { lat, lng } | Latitude and longitude object for delivery
| data.items | [{ size, qty }] | List of items' size and quantity objects


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


## Payment Status

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
3 | Medium (M) -  Laptop, PC, monitor.
4 | Large (L) - Chair, a small desk, bicycle.
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

`GET https://services.shippify.co/warehouse/list`

# Routes

Routes will cluster tasks and create a more efficient fare for all those tasks. The route can be assigned to a shipper so he can do the delivery of multiple tasks.

Routes that we currently support are:

* Common pickup location 
This routes are a group of task that have common pickup locations and different delivery locations.




# Widgets


Widgets allow companies to create, calculate and query tasks with a user interface provided by Shippify that can be customized with the look and feel of any UI.


Get an HTML embedded component from the company of the user. A list of all registered warehouses


The widget is initialized with some variables that will be documented soon.







