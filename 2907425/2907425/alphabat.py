import sys
import pickle
import operator
import itertools

alphabet = 'abcdefghijklmnopqrstuvwxyz'

#test if a word uses letters at most once
def monoglyphic(word):
	word = sorted(word)
	for i in range(1,len(word)):
		if word[i]==word[i-1]:
			return False
	return True

#make forwards and backwards trees of words
#forwards has all substrings (x1,..,xn),(x2,..,xn),... (xn) for words (x1,...,xn)
#backwards has all substrings (xn),(xn,xn-1),...,(xn,...,x1)
#use to calculate word overlaps
def make_prefs():
	forwards = {}
	backwards = {}
	for word in words:
		fbase = forwards
		bbase = backwards
		l = len(word)
		for i in range(0,l):
			fbase,fbucket = fbase.setdefault(word[i],({},[]))
			bbase,bbucket = bbase.setdefault(word[l-i-1],({},[]))

		fbucket.append(word)
		bbucket.append(word)
	return (forwards,backwards)

def gather(base):
	l = []
	for b2,bucket in base.values():
		l += bucket
		l += gather(b2)
	return l

#return all words which overlap with the left of word
#eg 'dog' overlaps with 'ogle'
def left_overlaps(word,backwards):
	overlaps = []
	l = len(word)
	base = backwards
	for i in range(l,0,-1):
		base,bucket = base[word[i-1]]
		w2 = bucket[0][:l-i]+word
		if monoglyphic(w2):
			overlaps += bucket
	overlaps += gather(base)
	return overlaps

#
def calc_subs():
	subs = {}
	for word in words:
		d = subs[word] = []
		l=len(word)
		for i in range(0,l-1):
			j=i
			base=forwards
			while j<l and word[j] in base:
				base,bucket=base[word[j]]
				d+=bucket
				j+=1
		d.sort()
	return subs

#load words with no repeated letters
words = [word.strip() for word in open('monoglyphs.txt').readlines()]
#compute spelling trees forwards and backwards (for prefix/suffix overlaps)
forwards,backwards = make_prefs()
#for each word, calculate a list of all the subwords it contains
subs = calc_subs()

if __name__=='__main__':
	#sort words by the number of words they contain
	ranking = sorted([(word,len(subs[word])) for word in words],key=operator.itemgetter(1))	#operator.itemgetter(1) means sort by the second part of the tuple

	print('Top words')
	for word,score in ranking[-10:]:
		print('%s  %i' %(word,score))
	word,score=ranking[-1]
	print(word+' contains '+', '.join(subs[word]))