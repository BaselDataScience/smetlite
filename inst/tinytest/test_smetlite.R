# Check with simple test SMET file
xx <- read_smet(system.file('extdata', 'test.smet', package = 'smetlite'))
attr(xx, 'file') <- 'test.smet'
expect_equal(xx, test_smet)
