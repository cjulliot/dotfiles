#!/bin/bash

BASHRC=~/.bashrc

if [ -f $BASHRC ];
then
	cp $BASHRC ~/.bashrc.backup
	rm $BASHRC
fi

ln -s $(pwd)/.bashrc $BASHRC
ln -s $(pwd)/.vimrc ~/.vimrc
