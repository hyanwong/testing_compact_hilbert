
HDF5_HOME=/usr
PYTHON=python

hilbert:
	g++ -L$(HDF5_HOME)/lib $(HDF5_HOME)/lib/libhdf5_hl.a $(HDF5_HOME)/lib/libhdf5.a -lz -ldl -lm -I$(HDF5_HOME)/include -Ilibhilbert/include -O2 -o hilbert hilbert.cxx libhilbert/src/.libs/libHilbert.a -lhdf5

hilbert_%.h5: hilbert
	./hilbert $@ $(subst x, ,$*) 


test_%: hilbert_%.h5 compare_%

compare_%: hilbert_%.h5
	$(PYTHON) test_compact_hilbert.py $(subst x, ,$*)
