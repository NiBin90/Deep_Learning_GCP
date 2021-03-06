#!/usr/bin/env bash

set -e
set -o xtrace
DEBIAN_FRONTEND=noninteractive

sudo apt update
sudo apt install unzip -y
sudo apt -y upgrade --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
sudo apt -y autoremove
sudo apt update
mkdir downloads
cd downloads
wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
bash Anaconda3-5.0.1-Linux-x86_64.sh -b
cd ~
git clone https://github.com/fastai/fastai.git
cd fastai/
echo 'export PATH=~/anaconda3/bin:$PATH' >> ~/.bashrc
export PATH=~/anaconda3/bin:$PATH
source ~/.bashrc
conda env update
echo 'source activate fastai' >> ~/.bashrc
source activate fastai
source ~/.bashrc
cd ..
mkdir data
cd data
wget http://files.fast.ai/data/dogscats.zip
unzip -q dogscats.zip
cd ../fastai/courses/dl1/
ln -s ~/data ./
jupyter notebook --generate-config
echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ports = 5000" >> ~/.jupyter/jupyter_notebook_config.py
pip install ipywidgets
jupyter nbextension enable --py widgetsnbextension --sys-prefix
echo
echo ---
echo - YOU NEED TO REBOOT YOUR PAPERSPACE COMPUTER NOW
echo ---
