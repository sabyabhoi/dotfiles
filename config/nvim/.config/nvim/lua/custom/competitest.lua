local competitest_status_ok, competitest = pcall(require, "competitest")
if not competitest_status_ok then
	return
end

competitest.setup({
	testcases_directory = "./testcases",
	maximum_time = 2000,
})
