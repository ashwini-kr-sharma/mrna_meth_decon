# mrna_meth_decon

> NOTE: If you don't want to build the Docker image yourself, directly go to the last section.

### Create a Docker image

```
# cd <any root directory>, In our case -
cd ~/

git clone https://github.com/ashwini-kr-sharma/mrna_meth_decon.git && cd mrna_meth_decon
docker build -t ashwinikrsharma/mrna_meth_decon .
docker push ashwinikrsharma/mrna_meth_decon

```

### Explore the Docker container

```
docker run --rm -it ashwinikrsharma/mrna_meth_decon:latest bash

# A bash terminal inside the Docker container should open

# Start R
R

# Inside the R console, identify if the deconvolution packages are present
ip = as.data.frame(installed.packages()[,c(1,3:4)])
ip = ip[is.na(ip$Priority),1:2,drop=FALSE]

mypacakages = c('DeconRNASeq','EpiDISH', 'estimate', 'ica', 'fastICA', 'NMF', 'fgsea', 'enrichR', 'immunedeconv', 'deconica', 'EDec', 'MeDeCom', 'medepir', 'CellMix')

# All available !
ip[ip$Package %in% mypacakages,]

# Any missing !
mypacakages[! mypacakages %in% ip$Package]

# Exit R
q()

# Exit container bash
exit

```

### Available algorithms

- immunedeconv
- estimate
- CellMix
- DeconRNASeq

- EpiDISH
- EDec
- medepir

- ica
- deconica
- fastICA
- NMF

### Connecting this docker image with `ShinyCompExplore` and running the app

[`ShinyCompExplore`](https://github.com/ashwini-kr-sharma/ShinyCompExplore) is a Shiny app that aids in a user-friendly analysis and visualization of various deconvolution algorithms.

```
cd ~/

# In case you didn't build the Docker image following the steps above,
# you can directly pull the built image from dockerhub

docker pull ashwinikrsharma/mrna_meth_decon

git clone https://github.com/ashwini-kr-sharma/ShinyCompExplore.git

docker run --rm -it -p 3838:3838 -v ~/ShinyCompExplore:/srv/shiny-server/ ashwinikrsharma/mrna_meth_decon

# Wait for few seconds for the shiny app to start

```

Once you see a message `hello world`, go to your browser (Chrome, Firefox etc) and type in the address bar `localhost:3838`, you should now be able to see the `ShinyCompExplore` app.
