#!/bin/sh

export SECRET_KEY_BASE=$(RAILS_ENV=production rake secret)

rails s -e production
