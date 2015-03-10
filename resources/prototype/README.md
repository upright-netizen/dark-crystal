# A PROTOTYPE SOMETHING

## How to deploy to Heroku

**Step 1**: go to the directory of your thing create a heroku thing.

    $> heroku create

**Step 2**: Push code to Heroku

    $> git push heroku master

**Step 3**: Start up a dynamo

    $> heroku ps:scale web=1

**Step 4**: Open it in a web broswer

    $> heroku open