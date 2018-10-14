# Dividi

## Installation

### Requirements

Before you get started, the following needs to be installed:
* **Ruby**:

  Version 2.4.4 is currently used and we don't guarantee everything works with other versions. If you need multiple versions of Ruby, [rbenv](https://github.com/rbenv/rbenv) is recommended.
* **Bundler**:
  ```
  gem install bundler
  ```
* [**Git**](http://help.github.com/git-installation-redirect)
* **Yarn**:

  You can install Yarn through the Homebrew package manager. This will also install Node.js if it is not already installed :
  ```
  brew install yarn
  ```
  If you use nvm or similar, you should exclude installing Node.js so that nvm's version of Node.js is used:
  ```
  brew install yarn --without-node
  ```
* **A database**:

  Only Postgresql has been tested, so we give no guarantees that other databases work. You can install Postgresql:
  ```bash
  brew install postgresql
  brew services start postgresql
  ```

### Setting up the development environment
  1.  Get the code. Clone this git repository :
  ```bash
  git clone git@github.com:thibault173/dividi.git
  cd dividi
  ```

  2.  Install the required gems by running the following command in the project root directory :

  ```bash
  bundle install
  ```

  3. Install all the dependencies of project :
  ```bash
  yarn install
  ```

  4. Create database :
  ```bash
  bundle exec rake db:create
  ```

  5. Update your local database schema to the newest version, run database migrations with :
  ```bash
  bundle exec rake db:migrate
  ```
---

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
