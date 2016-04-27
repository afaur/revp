# Why?

Be able to generate commands that need date ranges.

# Getting started

## Download

~~~
git clone git@github.com:afaur/revp.git
cd revp
~~~

## Ruby

### RVM

~~~
rvm install jruby-2.1.5
~~~

### rbenv

~~~
rbenv install ruby-2.1.5
rbenv local ruby-2.1.5
~~~

## Running

~~~
bundle install
./revp --help
~~~

# Examples
~~~
./revp --start="2012 1 1 0 0 0" --end="2016 4 27 0 0 0" --phrase="in one day"
./revp --start="2016 1 16 0 0 0" --end="2016 1 16 0 0 0" --phrase="in two
seconds"
~~~

