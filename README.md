
# TaiwanMetal

This applicaiton is created to solve the daily chores that a jewely store owner has to face. The app equip with basic sales and inventory management capabilities. As for now, you are recommended to use this app in desktop environment with google chrome browser. In future version of this app, it will allow more interactivities between members.


## Table of content

[Requirements](#Requirements)
[Usage](#Usage)  

  - [Install Dependency](#Install-Dependency)  
  - [Prepare Database](#Prepare-Database)
  - [Start server](#Start-server)
  - [Create public menus](#Create-public-menus)
  - [Modify application.yml file](#Modify-application.yml-file)
  - [Check routes](#Check-routes)
  - [Process](#Process)

***

## Requirements

- Ruby version 2.6.3
- Rails version 6.0.3
- PostgreSQL 11.5

## Usage

### Install Dependency

```
$ bundle install
```

### Prepare Database

If you didn't have database.

```
$ rails db:create
$ rails db:migrate
```

### Start server

Start Rails server.

```
$ rails s
```

### Modify application.yml file

To make "Facebook & Google API" work properly, you should customize your own `application.yml` file，for more info, please check `application.yml.sample` file and fill in your own credentials.

### Check routes:

Check rails routes for more detail:

```
$ rails routes
```


| Pages                | Prefix                 | URI Pattern                      |
| -------------------- | :--------------------- | :------------------------------- |
| User sign up:        | new_user_registration  | `/users/sign_up(.:format)`       |
| User sign in:        | new_user_session       | `/users/sign_in(.:format)`       |
| User edit:           | edit_user_registration | `/users/edit(.:format)`          |
| Homepage:            | pages                  | `/(.:format)`                    |
| Products you owned:  | products               | `/products(.:format)`            |
| Create a new Product:| new_product            | `/products/new(.:format)`        |
| Show a Product:      | products               | `/products/:id(.:format)`        |
| Edit a Product:      | edit_products          | `/products/:id/edit(.:format)`   |

***

### Process

***

After login with email or with Google/Facebook account, visit `/product/new`, you can start to add a new product with automatically generate barcode and capability to upload product image. 

- Create your first Product

Every product you own are showen here. By simply click the name of your product, you would see more detailed features of the product 

- Edit your created Setbox 

Click the product name which you want to edit. If you are interested in editing any features of the product, you can hit edit button in the content page, and start your updating process.

- See all of your Products

All products you added can be found in product lists link which is under inventory dropdown

