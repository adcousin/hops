# Hops!... I did it again!

This was the final project of **[the Wagon Bootcamp Course](https://www.lewagon.com/fr "Check it out")** which was made in **9 days**  by **a team of four people**.

## Have a look

**Our project** is available **[here][Hops]** for you to _see all these features_ in action.

## The Issue

The _number of beers_ is **steadily increasing** due to the ***growing popularity*** of this _type of beverage_. It has become _increasingly **difficult**_ to **keep track** of _which beer_ has been tried and **if it was good**.

## Existing solution

### Notebooks

Writing this information in a notebook can seem a good idea but it comes with disavantages :

- You **always need to carry it** on yourself _wherever_ you go _in case_ someone offers you to grab a drink.
- You **need to be consistant** in the way you _document your discoveries_.
- ***If you lose it***, you ***loose all your precious informations*** _without hope of getting it back_.

## Our Solution

### A Ruby on Rails project

A progressive web application (PWA) seemed a logical choice to solve these issues :

- It **can be accessed** from _anywhere_ and on _any device_.
- The data you enters is _already formated_ in a **pleasing way** for you.
- _If you lose your phone_, the data is **persisted** and ***is still available*** to _you_.

## The Features

This section is divided between the differents sections of our project for lisibility but they are related in the actual website.

### Beers section

This is ***the core*** of our website which provides **important informations on _beers_ to our users**

Mobile

<img src="https://user-images.githubusercontent.com/58084593/105690905-d8fa8b80-5efc-11eb-9243-653c6944d30a.png" alt="BeersMobile" width="200 px"/>

Desktop

<img src="https://user-images.githubusercontent.com/58084593/105638618-e3247780-5e73-11eb-9782-9a2059d99102.png" alt="BeersDesktop" />

#### Related features

##### Beer Details

- A User can see the **recently added beers**.
- On a ***chosen beer***, a user can see the following informations :
  - Their **style** such as _IPA, Triple..._
  - Their **color**  such as _Blond, Amber..._ (which also generate, _on click_, a **search query** to see **related beers**)
  - Their **alcohol strength**
  - The **country of origin**
  - Their **brewery** (which _also leads_ to the **related page**)

##### Search

- A User can do a **named search** for a ***particular beer***
- A user **can search** for a ***particular color of beer***
- A ***bar code can be scanned*** to _fetch the **related beer** from our database_ or to **prefill a form** to create if not absent

##### Reviews and listing

- A User **can add a review** of a _selected beer_, _review_ made of a **0 to 5 rating** alongside **a comment**
- **A beer can be added** to one of the **main list** which are the following :

  - The **Whitelist** to store ***liked beers***
  - The **Blacklist** to store those which **shouldn't be tasted** ***ever again***
  - The **Wishlist** to store beers that our users **would like to try** in the future

- A user can see **statistics related to those main lists** in order to have a _better appreciation_ of **how this beer is perceived by other people**
- A user can also **create customs lists**, which are _also made to store beers_, and **name them as they like**

##### Community oriented

- Users can **add beers** if they are _not yet present_ in our database
- Users can **edit existing beers** if they think an information is invalid
- _When on a beer page_, a user can see **related community suggestion** based on _their likings_

### Brewery section

This section of the website gives ***additionnal information on the breweries*** that makes all **those good**, _and sometimes not so good_, **beers**

Mobile

<img src="https://user-images.githubusercontent.com/58084593/105692030-3d6a1a80-5efe-11eb-927e-df6cb2e42b90.png" alt="BeersMobile" width="200 px"/>

Desktop

<img src="https://user-images.githubusercontent.com/58084593/105638669-2bdc3080-5e74-11eb-9b32-dc118164de72.png" alt="BreweryDesktop" />

#### Related features

##### Brewery's beers and filtering

- Our users can view **how many** _beers_ **this brewery is producing** and the **name of each one** with some details like the **color** and the **alcohol strength**
- They can see **how many of each beers color** there are **available** at this _brewery_
- Our users can **filter them by color** to ***only display the kind of beers*** they want to see

##### Community Statistics

- User can see *how the beers* from ***this brewery*** have been **rated overall**

##### Location

- A **map is provided**, alongside the **address**, to give the user a **visual idea** of _where_ the brewery is located

### Cellar Features

This section displays what beers the user chose in the beer section

Mobile

<img src="https://user-images.githubusercontent.com/58084593/105692195-67234180-5efe-11eb-879a-06d920776827.png" alt="CellarMobile" width="200 px"/>

Desktop

<img src="https://user-images.githubusercontent.com/58084593/105692455-bbc6bc80-5efe-11eb-9a23-012dcad9af17.png" alt="CellarDesktop"/>

#### Related Features

##### List display

- A user can have a **global appreciation** of _how many beers_ there are in **each** of **their lists**
- A user can **remove beers** from **their lists**
- They can see if a beer is ***present across multiples lists***
- They can ***delete, create and edit*** customs lists.

### Side note

You *may experience* ***some latency*** while _first accessing_ our website, this is **due to our hosting service** and is beyond our control.

Please _be patient_ and feel free to **grab a beer** while it loads.

[Hops]:https://hops-505.herokuapp.com/
