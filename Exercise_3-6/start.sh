#!/bin/sh

export SECRET_KEY_BASE=$(RAILS_ENV=production rake secret)
bin/rails s -e production
