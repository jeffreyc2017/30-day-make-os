# The root directory to start the search
ROOT_DIR := ./projects

.PHONY: all src_only git_restore

all:
	$(MAKE) -C $(ROOT_DIR)/02_day/helloos5

	$(MAKE) -C $(ROOT_DIR)/03_day/harib00a
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00b
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00c
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00d
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00e
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00f
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00g
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00h
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00i
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00j

	$(MAKE) -C $(ROOT_DIR)/04_day/harib01a
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01b
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01c
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01d
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01e
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01f
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01g
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01h

	$(MAKE) -C $(ROOT_DIR)/05_day/harib02a
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02b
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02c
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02d
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02e
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02f
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02g
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02h
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02i

	$(MAKE) -C $(ROOT_DIR)/06_day/harib03a
	$(MAKE) -C $(ROOT_DIR)/06_day/harib03b
	$(MAKE) -C $(ROOT_DIR)/06_day/harib03c
	$(MAKE) -C $(ROOT_DIR)/06_day/harib03d
	$(MAKE) -C $(ROOT_DIR)/06_day/harib03e

	$(MAKE) -C $(ROOT_DIR)/07_day/harib04a
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04b
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04c
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04d
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04e
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04f
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04g

	$(MAKE) -C $(ROOT_DIR)/08_day/harib05a
	$(MAKE) -C $(ROOT_DIR)/08_day/harib05b
	$(MAKE) -C $(ROOT_DIR)/08_day/harib05c
	$(MAKE) -C $(ROOT_DIR)/08_day/harib05d

	$(MAKE) -C $(ROOT_DIR)/09_day/harib06a
	$(MAKE) -C $(ROOT_DIR)/09_day/harib06b
	$(MAKE) -C $(ROOT_DIR)/09_day/harib06c
	$(MAKE) -C $(ROOT_DIR)/09_day/harib06d

	$(MAKE) -C $(ROOT_DIR)/10_day/harib07a
	$(MAKE) -C $(ROOT_DIR)/10_day/harib07b
	$(MAKE) -C $(ROOT_DIR)/10_day/harib07c
	$(MAKE) -C $(ROOT_DIR)/10_day/harib07d

	$(MAKE) -C $(ROOT_DIR)/11_day/harib08a
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08b
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08c
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08d
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08e
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08f
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08g
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08h

	$(MAKE) -C $(ROOT_DIR)/12_day/harib09a
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09b
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09c
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09d
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09e
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09f
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09g

	$(MAKE) -C $(ROOT_DIR)/13_day/harib10a
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10b
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10c
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10d
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10e
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10f
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10g
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10h
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10i

	$(MAKE) -C $(ROOT_DIR)/14_day/harib11a
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11b
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11c
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11d
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11e
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11f
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11g
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11h
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11i

	$(MAKE) -C $(ROOT_DIR)/15_day/harib12a
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12b
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12c
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12d
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12e
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12f
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12g

	$(MAKE) -C $(ROOT_DIR)/16_day/harib13a
	$(MAKE) -C $(ROOT_DIR)/16_day/harib13b
	$(MAKE) -C $(ROOT_DIR)/16_day/harib13c
	$(MAKE) -C $(ROOT_DIR)/16_day/harib13d
	$(MAKE) -C $(ROOT_DIR)/16_day/harib13e

	$(MAKE) -C $(ROOT_DIR)/17_day/harib14a
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14b
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14c
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14d
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14e
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14f
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14g

	$(MAKE) -C $(ROOT_DIR)/18_day/harib15a
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15b
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15c
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15d
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15e
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15f
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15g

	$(MAKE) -C $(ROOT_DIR)/19_day/harib16a
	$(MAKE) -C $(ROOT_DIR)/19_day/harib16b
	$(MAKE) -C $(ROOT_DIR)/19_day/harib16c
	$(MAKE) -C $(ROOT_DIR)/19_day/harib16d
	$(MAKE) -C $(ROOT_DIR)/19_day/harib16e

	$(MAKE) -C $(ROOT_DIR)/20_day/harib17a
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17b
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17c
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17d
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17e
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17f
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17g
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17h

	$(MAKE) -C $(ROOT_DIR)/21_day/harib18a
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18b
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18c
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18d
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18e
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18f
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18g

	$(MAKE) -C $(ROOT_DIR)/22_day/harib19a
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19b
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19c
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19d
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19e
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19f
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19g

	$(MAKE) -C $(ROOT_DIR)/23_day/harib20a
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20b
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20c
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20d
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20e
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20f
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20g
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20h

	$(MAKE) -C $(ROOT_DIR)/24_day/harib21a
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21b
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21c
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21d
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21e
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21f
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21g
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21h

	$(MAKE) -C $(ROOT_DIR)/25_day/harib22a
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22b
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22c
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22d
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22e
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22f
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22g
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22h
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22i
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22j

	$(MAKE) -C $(ROOT_DIR)/26_day/harib23a
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23b
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23c
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23d
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23e
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23f
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23g
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23h
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23i
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23j

	$(MAKE) -C $(ROOT_DIR)/27_day/harib24a
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24b
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24c
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24d
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24e
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24f
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24g full

	$(MAKE) -C $(ROOT_DIR)/28_day/harib25a full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25b full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25c full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25d full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25e full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25f full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25g full

	$(MAKE) -C $(ROOT_DIR)/29_day/harib26a full
	$(MAKE) -C $(ROOT_DIR)/29_day/harib26b full
	$(MAKE) -C $(ROOT_DIR)/29_day/harib26c full
	$(MAKE) -C $(ROOT_DIR)/29_day/harib26d full
	$(MAKE) -C $(ROOT_DIR)/29_day/harib26e full

	$(MAKE) -C $(ROOT_DIR)/30_day/harib27a full
	$(MAKE) -C $(ROOT_DIR)/30_day/harib27b full
	$(MAKE) -C $(ROOT_DIR)/30_day/harib27c full
	$(MAKE) -C $(ROOT_DIR)/30_day/harib27d full
	$(MAKE) -C $(ROOT_DIR)/30_day/harib27e full
	$(MAKE) -C $(ROOT_DIR)/30_day/harib27f full

src_only:
	$(MAKE) -C $(ROOT_DIR)/02_day/helloos5 src_only

	$(MAKE) -C $(ROOT_DIR)/03_day/harib00a src_only
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00b src_only
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00c src_only
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00d src_only
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00e src_only
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00f src_only
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00g src_only
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00h src_only
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00i src_only
	$(MAKE) -C $(ROOT_DIR)/03_day/harib00j src_only

	$(MAKE) -C $(ROOT_DIR)/04_day/harib01a src_only
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01b src_only
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01c src_only
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01d src_only
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01e src_only
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01f src_only
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01g src_only
	$(MAKE) -C $(ROOT_DIR)/04_day/harib01h src_only

	$(MAKE) -C $(ROOT_DIR)/05_day/harib02a src_only
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02b src_only
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02c src_only
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02d src_only
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02e src_only
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02f src_only
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02g src_only
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02h src_only
	$(MAKE) -C $(ROOT_DIR)/05_day/harib02i src_only

	$(MAKE) -C $(ROOT_DIR)/06_day/harib03a src_only
	$(MAKE) -C $(ROOT_DIR)/06_day/harib03b src_only
	$(MAKE) -C $(ROOT_DIR)/06_day/harib03c src_only
	$(MAKE) -C $(ROOT_DIR)/06_day/harib03d src_only
	$(MAKE) -C $(ROOT_DIR)/06_day/harib03e src_only

	$(MAKE) -C $(ROOT_DIR)/07_day/harib04a src_only
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04b src_only
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04c src_only
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04d src_only
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04e src_only
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04f src_only
	$(MAKE) -C $(ROOT_DIR)/07_day/harib04g src_only

	$(MAKE) -C $(ROOT_DIR)/08_day/harib05a src_only
	$(MAKE) -C $(ROOT_DIR)/08_day/harib05b src_only
	$(MAKE) -C $(ROOT_DIR)/08_day/harib05c src_only
	$(MAKE) -C $(ROOT_DIR)/08_day/harib05d src_only

	$(MAKE) -C $(ROOT_DIR)/09_day/harib06a src_only
	$(MAKE) -C $(ROOT_DIR)/09_day/harib06b src_only
	$(MAKE) -C $(ROOT_DIR)/09_day/harib06c src_only
	$(MAKE) -C $(ROOT_DIR)/09_day/harib06d src_only

	$(MAKE) -C $(ROOT_DIR)/10_day/harib07a src_only
	$(MAKE) -C $(ROOT_DIR)/10_day/harib07b src_only
	$(MAKE) -C $(ROOT_DIR)/10_day/harib07c src_only
	$(MAKE) -C $(ROOT_DIR)/10_day/harib07d src_only

	$(MAKE) -C $(ROOT_DIR)/11_day/harib08a src_only
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08b src_only
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08c src_only
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08d src_only
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08e src_only
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08f src_only
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08g src_only
	$(MAKE) -C $(ROOT_DIR)/11_day/harib08h src_only

	$(MAKE) -C $(ROOT_DIR)/12_day/harib09a src_only
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09b src_only
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09c src_only
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09d src_only
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09e src_only
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09f src_only
	$(MAKE) -C $(ROOT_DIR)/12_day/harib09g src_only

	$(MAKE) -C $(ROOT_DIR)/13_day/harib10a src_only
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10b src_only
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10c src_only
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10d src_only
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10e src_only
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10f src_only
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10g src_only
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10h src_only
	$(MAKE) -C $(ROOT_DIR)/13_day/harib10i src_only

	$(MAKE) -C $(ROOT_DIR)/14_day/harib11a src_only
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11b src_only
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11c src_only
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11d src_only
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11e src_only
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11f src_only
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11g src_only
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11h src_only
	$(MAKE) -C $(ROOT_DIR)/14_day/harib11i src_only

	$(MAKE) -C $(ROOT_DIR)/15_day/harib12a src_only
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12b src_only
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12c src_only
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12d src_only
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12e src_only
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12f src_only
	$(MAKE) -C $(ROOT_DIR)/15_day/harib12g src_only

	$(MAKE) -C $(ROOT_DIR)/16_day/harib13a src_only
	$(MAKE) -C $(ROOT_DIR)/16_day/harib13b src_only
	$(MAKE) -C $(ROOT_DIR)/16_day/harib13c src_only
	$(MAKE) -C $(ROOT_DIR)/16_day/harib13d src_only
	$(MAKE) -C $(ROOT_DIR)/16_day/harib13e src_only

	$(MAKE) -C $(ROOT_DIR)/17_day/harib14a src_only
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14b src_only
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14c src_only
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14d src_only
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14e src_only
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14f src_only
	$(MAKE) -C $(ROOT_DIR)/17_day/harib14g src_only

	$(MAKE) -C $(ROOT_DIR)/18_day/harib15a src_only
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15b src_only
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15c src_only
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15d src_only
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15e src_only
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15f src_only
	$(MAKE) -C $(ROOT_DIR)/18_day/harib15g src_only

	$(MAKE) -C $(ROOT_DIR)/19_day/harib16a src_only
	$(MAKE) -C $(ROOT_DIR)/19_day/harib16b src_only
	$(MAKE) -C $(ROOT_DIR)/19_day/harib16c src_only
	$(MAKE) -C $(ROOT_DIR)/19_day/harib16d src_only
	$(MAKE) -C $(ROOT_DIR)/19_day/harib16e src_only

	$(MAKE) -C $(ROOT_DIR)/20_day/harib17a src_only
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17b src_only
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17c src_only
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17d src_only
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17e src_only
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17f src_only
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17g src_only
	$(MAKE) -C $(ROOT_DIR)/20_day/harib17h src_only

	$(MAKE) -C $(ROOT_DIR)/21_day/harib18a src_only
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18b src_only
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18c src_only
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18d src_only
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18e src_only
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18f src_only
	$(MAKE) -C $(ROOT_DIR)/21_day/harib18g src_only

	$(MAKE) -C $(ROOT_DIR)/22_day/harib19a src_only
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19b src_only
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19c src_only
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19d src_only
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19e src_only
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19f src_only
	$(MAKE) -C $(ROOT_DIR)/22_day/harib19g src_only

	$(MAKE) -C $(ROOT_DIR)/23_day/harib20a src_only
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20b src_only
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20c src_only
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20d src_only
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20e src_only
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20f src_only
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20g src_only
	$(MAKE) -C $(ROOT_DIR)/23_day/harib20h src_only

	$(MAKE) -C $(ROOT_DIR)/24_day/harib21a src_only
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21b src_only
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21c src_only
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21d src_only
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21e src_only
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21f src_only
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21g src_only
	$(MAKE) -C $(ROOT_DIR)/24_day/harib21h src_only

	$(MAKE) -C $(ROOT_DIR)/25_day/harib22a src_only
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22b src_only
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22c src_only
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22d src_only
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22e src_only
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22f src_only
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22g src_only
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22h src_only
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22i src_only
	$(MAKE) -C $(ROOT_DIR)/25_day/harib22j src_only

	$(MAKE) -C $(ROOT_DIR)/26_day/harib23a src_only
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23b src_only
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23c src_only
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23d src_only
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23e src_only
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23f src_only
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23g src_only
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23h src_only
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23i src_only
	$(MAKE) -C $(ROOT_DIR)/26_day/harib23j src_only

	$(MAKE) -C $(ROOT_DIR)/27_day/harib24a src_only
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24b src_only
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24c src_only
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24d src_only
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24e src_only
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24f src_only
	$(MAKE) -C $(ROOT_DIR)/27_day/harib24g src_only_full

	$(MAKE) -C $(ROOT_DIR)/28_day/harib25a src_only_full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25b src_only_full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25c src_only_full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25d src_only_full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25e src_only_full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25f src_only_full
	$(MAKE) -C $(ROOT_DIR)/28_day/harib25g src_only_full

	$(MAKE) -C $(ROOT_DIR)/29_day/harib26a src_only_full
	$(MAKE) -C $(ROOT_DIR)/29_day/harib26b src_only_full
	$(MAKE) -C $(ROOT_DIR)/29_day/harib26c src_only_full
	$(MAKE) -C $(ROOT_DIR)/29_day/harib26d src_only_full
	$(MAKE) -C $(ROOT_DIR)/29_day/harib26e src_only_full

	$(MAKE) -C $(ROOT_DIR)/30_day/harib27a src_only_full
	$(MAKE) -C $(ROOT_DIR)/30_day/harib27b src_only_full
	$(MAKE) -C $(ROOT_DIR)/30_day/harib27c src_only_full
	$(MAKE) -C $(ROOT_DIR)/30_day/harib27d src_only_full
	$(MAKE) -C $(ROOT_DIR)/30_day/harib27e src_only_full
	$(MAKE) -C $(ROOT_DIR)/30_day/harib27f src_only_full

git_restore:
	git restore "**/*.hrb" "**/*.lib" "**/*.sys" "**/*.bin" "**/*.img" "**/*.obj"
