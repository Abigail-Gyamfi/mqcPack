#! /bin/bash -x

cd ../SCFenergy
rm outfile

mkdir test
# set up the Gaussian environment
export GauBINARY="${GAU_BINARY}"

mkdir test2
cd test2
rm -f test.com
echo "------------------------" >> ../outfile 2>&1
echo "Pass through MatFile test">> ../outfile
echo "------------------------" >> ../outfile 2>&1
cp ../../data/MatrixFile/rhf_h2-sto3g.mat . >> ../outfile
../SCFenergy rhf_h2-sto3g.mat ${GauBINARY} >> ../outfile
echo "-------------------------------" >> ../outfile 2>&1
echo "test.com Create MatrixFile test">> ../outfile
echo "-------------------------------" >> ../outfile 2>&1
cp ../../data/Gaussian_input/test.com . >> ../outfile
../SCFenergy test.com ${GauBINARY} >> ../outfile
cd ..
rm -r test2

mkdir test1071
cd test1071
echo "-------------------------------" >> ../outfile 2>&1
echo "test1071 Create MatrixFile test" >> ../outfile 2>&1
echo "-------------------------------" >> ../outfile 2>&1
cp ../../data/Gaussian_input/test1071.com . >> ../outfile
../SCFenergy test1071.com ${GauBINARY} >> ../outfile 2>&1
cd ..
rm -r test1071

mkdir test1129
cd test1129
cp ../../data/Gaussian_input/test1129.com . >> ../outfile
echo "-------------------------------" >> ../outfile 2>&1
echo "test1129 Create MatrixFile test" >> ../outfile 2>&1
echo "-------------------------------" >> ../outfile 2>&1
../SCFenergy test1129.com ${GauBINARY} >> ../outfile 2>&1
cd ..
rm -r test1129

mkdir test1132
cd test1132
cp ../../data/Gaussian_input/test1132.com . >> ../outfile
echo "--------------------------------" >> ../outfile 2>&1
echo "test1132 Create MatrixFiles test" >> ../outfile 2>&1
echo "--------------------------------" >> ../outfile 2>&1
../SCFenergy test1132.com ${GauBINARY} >> ../outfile 2>&1
echo "-----------------------------------------" >> ../outfile 2>&1
echo "test1132 Pass one MatrixFile through test" >> ../outfile 2>&1
echo "-----------------------------------------" >> ../outfile 2>&1
../SCFenergy test1132r.dat ${GauBINARY} >> ../outfile 2>&1
echo "------------------------------------------------------------------" >> ../outfile 2>&1
echo "test1132 Create One MartixFile and Pass through 3 MatrixFiles test" >> ../outfile 2>&1
echo "------------------------------------------------------------------" >> ../outfile 2>&1
../SCFenergy test1132.com test1132gr.dat test1132r.dat test1132u.dat ${GauBINARY} >> ../outfile 2>&1
cd ..
rm -r test1132

grep -v "echo argv" outfile > tmpfile 2>&1
grep -v "cp test1132" tmpfile > outfile 2>&1
grep -v "Gaussian Version:" outfile > tmpfile 2>&1
mv tmpfile outfile

diff -b -B outfile OUTPUT/out_runGau

exit
# tests 1130, 1135 and 1136 require R.  So a pain to run.
cd test1130
echo "test1130-Should be no problems" >> ../outfile 2>&1
../FullWavefunctionRW test1130.com ${GauBINARY} >> ../outfile 2>&1
cd ..

cd test1135
echo "test1135" >> ../outfile
../FullWavefunctionRW test1135.com g16 >> ../outfile
cd ..

cd test1136
echo "test1136" >> ../outfile
../FullWavefunctionRW test1136.com g16 >> ../outfile
cd ..

