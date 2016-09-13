require 'yaml'

instants_categories = [
  { id: 1, # среќни тркала 1
    categories: [
      { category: 1,  count:	      2, amount:	1_100_000, desc: 'VW Golf 6 TDI Trendline' },
      { category: 2,  count:	      5, amount:	  100_000, desc: '' },
      { category: 3,  count:	      6, amount:		 50_000, desc: '' },
      { category: 4,  count:	     20, amount:		 10_000, desc: '' },
      { category: 5,  count:	     60, amount:		  5_000, desc: '' },
      { category: 6,  count:	    200, amount:		  2_000, desc: '' },
      { category: 7,  count:	    600, amount:		  1_000, desc: '' },
      { category: 8,  count:	  2_000, amount:		    500, desc: '' },
      { category: 9,  count:	 10_000, amount:		    100, desc: '' },
      { category: 10, count: 	 50_000, amount:		     50, desc: '' },
      { category: 11, count: 	300_000, amount:		     30, desc: '' },
    ]
  },
  { id: 7, # седма брзина
    categories: [
      { category: 1, count: 	     10, amount:	1_030_200, desc: 'VW Golf 7' },
      { category: 2, count: 	     10, amount:	  100_000, desc: '' },
      { category: 3, count: 	     10, amount:	   50_000, desc: '' },
      { category: 4, count: 	  1_000, amount: 	      500, desc: '' },
      { category: 5, count: 	  5_000, amount: 	      200, desc: '' },
      { category: 6, count: 	 10_000, amount:	      100, desc: '' },
      { category: 7, count: 	 15_000, amount:	       80, desc: '' },
      { category: 8, count: 	280_000, amount:	       40, desc: '' },
    ]
  },

  { id: 8, # twingomania 1
    categories: [
      { category: 1, count:	     15, amount:	500_000, desc: 'Renault Twingo Trend' },
      { category: 2, count:	      5, amount:	100_000, desc: '' },
      { category: 3, count:	     50, amount:	 10_000, desc: '' },
      { category: 4, count:	    100, amount:	  5_000, desc: '' },
      { category: 5, count:	    500, amount:	  1_000, desc: '' },
      { category: 6, count:	  1_000, amount:	    500, desc: '' },
      { category: 7, count:	  5_000, amount:	    100, desc: '' },
      { category: 8, count:	 50_000, amount:	     50, desc: '' },
      { category: 9, count:	350_000, amount:	     30, desc: '' },
    ]
  },
  { id: 9, # twingomania 2
    categories: [
      { category: 1, count: 	     40, amount:	500_000, desc: 'Renault Twingo Trend' },
      { category: 2, count: 	     40, amount:	 25_000, desc: '' },
      { category: 3, count: 	    100, amount:	  4_000, desc: '' },
      { category: 4, count: 	    500, amount:	    800, desc: '' },
      { category: 5, count: 	  1_000, amount:	    400, desc: '' },
      { category: 6, count: 	  5_000, amount:	    240, desc: '' },
      { category: 7, count: 	 10_000, amount:	    120, desc: '' },
      { category: 8, count: 	 30_000, amount:	     80, desc: '' },
      { category: 9, count: 	630_000, amount:	     40, desc: '' },
    ]
  },
  { id: 20, # ZOO
    categories: [
      { category:  1, count: 	      1, amount: 	1_400_000, desc: 'Seat Leon FR' },
      { category:  2, count: 	      2, amount: 	  810_000, desc: 'Seat Leon Reference' },
      { category:  3, count: 	     10, amount: 	  100_000, desc: '' },
      { category:  4, count: 	    200, amount: 	    5_000, desc: '' },
      { category:  5, count: 	  2_000, amount: 	      500, desc: '' },
      { category:  6, count: 	  5_000, amount: 	      300, desc: '' },
      { category:  7, count: 	  5_000, amount: 	      200, desc: '' },
      { category:  8, count: 	 20_000, amount: 	      150, desc: '' },
      { category:  9, count: 	 30_000, amount: 	      100, desc: '' },
      { category: 10, count: 	280_000, amount: 	       50, desc: '' },
    ]
  },
  { id: 21, # Среќни коцки
    categories: [
      { category: 1, count:	      5, amount:  1_000_000, desc: '' },
      { category: 2, count:	     10, amount:	  100_000, desc: '' },
      { category: 3, count:	    100, amount:	   10_000, desc: '' },
      { category: 4, count:	  1_000, amount:	    1_000, desc: '' },
      { category: 5, count:	  5_000, amount:	      200, desc: '' },
      { category: 6, count:	 20_000, amount:	      100, desc: '' },
      { category: 7, count:	 25_000, amount:	       80, desc: '' },
      { category: 8, count:	300_000, amount:	       40, desc: '' },
    ]
  },
  { id: 22, # експрес лотарија
    categories: [
      { category: 1, count:	      1, amount:	300_000, desc: '' },
      { category: 2, count:	      5, amount:	100_000, desc: '' },
      { category: 3, count:	     20, amount:	  5_000, desc: '' },
      { category: 4, count:	    100, amount:	  1_000, desc: '' },
      { category: 5, count:	  5_000, amount:	    200, desc: '' },
      { category: 6, count:	 10_000, amount:	    100, desc: '' },
      { category: 7, count:	 20_000, amount:	     50, desc: '' },
      { category: 8, count:	135_000, amount:	     25, desc: '' },
    ]
  },
  { id: 23, # подарок
    categories: [
      { category: 1, count:     30, amount:	60_000, desc: '' },
      { category: 2, count:	   100, amount:	 5_000, desc: '' },
      { category: 3, count:	   500, amount:	 1_000, desc: '' },
      { category: 4, count:	 1_000, amount:	   500, desc: '' },
      { category: 5, count:	 3_000, amount:	   200, desc: '' },
      { category: 6, count:	15_000, amount:	   100, desc: '' },
      { category: 7, count:	81_000, amount:	    50, desc: '' },
    ]
  },
  { id: 24, # хороскоп
    categories: [
      { category:  1, count:	     30, amount:	30_000, desc: '' },
      { category:  2, count:	     60, amount:	10_000, desc: '' },
      { category:  3, count:	    100, amount:	 5_000, desc: '' },
      { category:  4, count:	    500, amount:	 1_000, desc: '' },
      { category:  5, count:	  1_000, amount:	   500, desc: '' },
      { category:  6, count:	  2_000, amount:	   300, desc: '' },
      { category:  7, count:	 10_000, amount:	    80, desc: '' },
      { category:  8, count:	 15_000, amount:	    60, desc: '' },
      { category:  9, count:	 30_000, amount:	    40, desc: '' },
      { category: 10, count:	300_000, amount:	    20, desc: '' },
    ]
  },
  { id: 25, # среќни тркала 3
    categories: [
      { category: 1, count:	      7, amount:  1_505_000, desc: 'VW Passat Trendline 1.4' },
      { category: 2, count:	     10, amount:	   50_000, desc: '' },
      { category: 3, count:	    200, amount:	    5_000, desc: '' },
      { category: 4, count:	  1_000, amount:	    1_000, desc: '' },
      { category: 5, count:	  3_000, amount:	      200, desc: '' },
      { category: 6, count:	  5_000, amount:	      150, desc: '' },
      { category: 7, count:	 25_000, amount:	      100, desc: '' },
      { category: 8, count:	200_000, amount:	       50, desc: '' },
      { category: 9, count:	120_000, amount:	       30, desc: '' },
    ]
  }, 
  { id: 30, # среќни тркала 2с
    categories: [
      { category: 1, count:	     20, amount:	560_000, desc: 'VW Polo Trendline 1.2' },
      { category: 2, count:	 50_000, amount:	     80, desc: '' },
      { category: 3, count:	280_000, amount:	     40, desc: '' },
    ]
  },
  { id: 41, # златна рипка
    categories: [
      { category:  1, count:       1, amount:  1_000_000, desc: '' },
      { category:  2, count:       2, amount: 	 500_000, desc: '' },
      { category:  3, count:      10, amount: 	 100_000, desc: '' },
      { category:  4, count:      15, amount: 	  50_000, desc: '' },
      { category:  5, count:      20, amount: 	  30_000, desc: '' },
      { category:  6, count:      25, amount: 	  20_000, desc: '' },
      { category:  7, count:      40, amount: 	  10_000, desc: '' },
      { category:  8, count:      65, amount: 	   5_000, desc: '' },
      { category:  9, count:      80, amount: 	   4_000, desc: '' },
      { category: 10, count:     100, amount: 	   3_000, desc: '' },
      { category: 11, count:     120, amount: 	   2_000, desc: '' },
      { category: 12, count:     170, amount: 	   1_000, desc: '' },
      { category: 13, count:     500, amount: 	     500, desc: '' },
      { category: 14, count:   1_000, amount: 	     400, desc: '' },
      { category: 15, count:   2_000, amount: 	     300, desc: '' },
      { category: 16, count:   3_200, amount: 	     200, desc: '' },
      { category: 17, count:   5_000, amount: 	     150, desc: '' },
      { category: 18, count:  10_000, amount: 	     100, desc: '' },
      { category: 19, count: 120_000, amount: 	      50, desc: '' },
    ]
  },
  { id: 44, # калинка
    categories: [
      { category: 1, count:	      1, amount:	500_000, desc: '' },
      { category: 2, count:	      5, amount:	100_000, desc: '' },
      { category: 3, count:	     10, amount:	 10_000, desc: '' },
      { category: 4, count:	     20, amount: 	  5_000, desc: '' },
      { category: 5, count:	    300, amount:	  1_000, desc: '' },
      { category: 6, count:	  1_000, amount:	    500, desc: '' },
      { category: 7, count:	 10_000, amount:	    100, desc: '' },
      { category: 8, count:	 30_000, amount:	     50, desc: '' },
      { category: 9, count:	150_000, amount:	     30, desc: '' },
    ]
  },
  { id: 45, # смајли
    categories: [
      { category: 1, count:	     35, amount:	130_000, 
        desc: 'Aprilia SR 50 | Gilera Runner 50 | Vespa LX 2T' },
      { category: 2, count:	 20_000, amount:	     50, desc: '' },
      { category: 3, count:	135_000, amount:	     30, desc: '' },
    ]
  },
  { id: 50,
    categories: [
      { category:  1, count:	      2, amount:	1_100_000, desc: 'Lancia Delta' },
      { category:  2, count:	      3, amount:	  500_000, desc: '' },
      { category:  3, count:	      5, amount:	  100_000, desc: '' },
      { category:  4, count:	     10, amount:	   50_000, desc: '' },
      { category:  5, count:	     20, amount:	   10_000, desc: '' },
      { category:  6, count:	    100, amount:	    5_000, desc: '' },
      { category:  7, count:	  1_000, amount:	      500, desc: '' },
      { category:  8, count:	 10_000, amount:	      100, desc: '' },
      { category:  9, count:	100_000, amount:	       50, desc: '' },
      { category: 10, count:	110_000, amount:	       30, desc: '' },
    ]
  },
  { id: 60,
    categories: [
      { category: 1, count:	      5, amount:	500_000, desc: '' },
      { category: 2, count:	     10, amount:	100_000, desc: '' },
      { category: 3, count:	    100, amount:	 10_000, desc: '' },
      { category: 4, count:	  1_000, amount:	  1_000, desc: '' },
      { category: 5, count:	  2_000, amount:	    500, desc: '' },
      { category: 6, count:	  5_000, amount:	    200, desc: '' },
      { category: 7, count:	 15_000, amount:	    100, desc: '' },
      { category: 8, count:	 25_000, amount:	     60, desc: '' },
      { category: 9, count:	300_000, amount:	     30, desc: '' },
    ]
  },
  { id: 61,
    categories: [
      { category: 1, count:	      5, amount:	500_000, desc: '' },
      { category: 2, count:	     10, amount:	100_000, desc: '' },
      { category: 3, count:	    100, amount:	 10_000, desc: '' },
      { category: 4, count:	  1_000, amount:	  1_000, desc: '' },
      { category: 5, count:	  2_000, amount:	    500, desc: '' },
      { category: 6, count:	  5_000, amount:	    200, desc: '' },
      { category: 7, count:	 15_000, amount:	    100, desc: '' },
      { category: 8, count:	 25_000, amount:	     60, desc: '' },
      { category: 9, count:	300_000, amount:	     30, desc: '' },
    ]
  },
  { id: 62,
    categories: [
      { category: 1, count:	      3, amount:	500_000, desc: '' },
      { category: 2, count:	     10, amount:	 50_000, desc: '' },
      { category: 3, count:	    100, amount:	  5_000, desc: '' },
      { category: 4, count:	    500, amount:	  1_000, desc: '' },
      { category: 5, count:	  2_000, amount:	    400, desc: '' },
      { category: 6, count:	  7_500, amount:	    200, desc: '' },
      { category: 7, count:	 20_000, amount:	     80, desc: '' },
      { category: 8, count:	140_000, amount:	     40, desc: '' },
    ]
  },
]

puts instants_categories.to_yaml
