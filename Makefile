.PHONY: clean

FLAGS=$(CXXFLAGS) -Wall -Wextra -pedantic -O3
FLAGS_SSE2=$(FLAGS) -msse4.2 -DUSE_SSE2
FLAGS_AVX2=$(FLAGS) -mavx2 -DUSE_SSE2 -DUSE_AVX2

OBJ=obj/null.o\
    obj/cpp11random.o\
    obj/boxmuller.o\
    obj/clt.o\
    obj/inverse.o\
    obj/marsagliapolar.o\
    obj/ziggurat.o\

OBJ_SSE2=obj/null_sse2.o\
         obj/cpp11random_sse2.o\
         obj/boxmuller_sse2.o\
         obj/clt_sse2.o\
         obj/inverse_sse2.o\
         obj/marsagliapolar_sse2.o\
         obj/ziggurat_sse2.o\

OBJ_AVX2=obj/null_avx2.o\
         obj/cpp11random_avx2.o\
         obj/boxmuller_avx2.o\
         obj/clt_avx2.o\
         obj/inverse_avx2.o\
         obj/marsagliapolar_avx2.o\
         obj/ziggurat_avx2.o\

ALL_OBJ=$(OBJ) $(OBJ_SSE2) $(OBJ_AVX2)

ALL=test test_sse2 test_avx2

all: $(ALL)

test: src/main.cpp src/timer.h src/test.h $(OBJ)
	$(CXX) $(FLAGS) $< $(OBJ) -o $@

test_sse2: src/main.cpp src/timer.h src/test.h $(OBJ_SSE2)
	$(CXX) $(FLAGS_SSE2) $< $(OBJ_SSE2) -o $@

test_avx2: src/main.cpp src/timer.h src/test.h $(OBJ_AVX2)
	$(CXX) $(FLAGS_AVX2) $< $(OBJ_AVX2) -o $@


################################################################################

TESTDEP=src/test.h src/lcg.h

################################################################################

obj/null.o: src/null.cpp $(TESTDEP)
	$(CXX) $(FLAGS) $< -c -o $@

obj/cpp11random.o: src/cpp11random.cpp $(TESTDEP)
	$(CXX) $(FLAGS) $< -c -o $@

obj/boxmuller.o: src/boxmuller.cpp $(TESTDEP)
	$(CXX) $(FLAGS) $< -c -o $@

obj/clt.o: src/clt.cpp $(TESTDEP)
	$(CXX) $(FLAGS) $< -c -o $@

obj/inverse.o: src/inverse.cpp $(TESTDEP)
	$(CXX) $(FLAGS) $< -c -o $@

obj/marsagliapolar.o: src/marsagliapolar.cpp $(TESTDEP)
	$(CXX) $(FLAGS) $< -c -o $@

obj/ziggurat.o: src/ziggurat.cpp $(TESTDEP)
	$(CXX) $(FLAGS) $< -c -o $@

################################################################################

obj/null_sse2.o: src/null.cpp $(TESTDEP)
	$(CXX) $(FLAGS_SSE2) $< -c -o $@

obj/cpp11random_sse2.o: src/cpp11random.cpp $(TESTDEP)
	$(CXX) $(FLAGS_SSE2) $< -c -o $@

obj/boxmuller_sse2.o: src/boxmuller_sse2.cpp $(TESTDEP)
	$(CXX) $(FLAGS_SSE2) $< -c -o $@

obj/clt_sse2.o: src/clt_sse2.cpp $(TESTDEP)
	$(CXX) $(FLAGS_SSE2) $< -c -o $@

obj/inverse_sse2.o: src/inverse.cpp $(TESTDEP)
	$(CXX) $(FLAGS_SSE2) $< -c -o $@

obj/marsagliapolar_sse2.o: src/marsagliapolar.cpp $(TESTDEP)
	$(CXX) $(FLAGS_SSE2) $< -c -o $@

obj/ziggurat_sse2.o: src/ziggurat.cpp $(TESTDEP)
	$(CXX) $(FLAGS_SSE2) $< -c -o $@

################################################################################

obj/null_avx2.o: src/null.cpp $(TESTDEP)
	$(CXX) $(FLAGS_AVX22) $< -c -o $@

obj/cpp11random_avx2.o: src/cpp11random.cpp $(TESTDEP)
	$(CXX) $(FLAGS_AVX22) $< -c -o $@

obj/boxmuller_avx2.o: src/boxmuller_sse2.cpp $(TESTDEP)
	$(CXX) $(FLAGS_AVX22) $< -c -o $@

obj/clt_avx2.o: src/clt_sse2.cpp $(TESTDEP)
	$(CXX) $(FLAGS_AVX22) $< -c -o $@

obj/inverse_avx2.o: src/inverse.cpp $(TESTDEP)
	$(CXX) $(FLAGS_AVX22) $< -c -o $@

obj/marsagliapolar_avx2.o: src/marsagliapolar.cpp $(TESTDEP)
	$(CXX) $(FLAGS_AVX22) $< -c -o $@

obj/ziggurat_avx2.o: src/ziggurat.cpp $(TESTDEP)
	$(CXX) $(FLAGS_AVX22) $< -c -o $@

clean:
	$(RM) $(ALL) $(ALL_OBJ)
