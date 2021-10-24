function foo(num: number) {
	// const fizzbuzz = buzz();
	// console.log({ fizzbuzz });
	return num;
}

foo(5)

foo()

foo('')

// These won't error in Coc.nvim unless tsconfig has strict:true
foo(null)
foo(undefined)
