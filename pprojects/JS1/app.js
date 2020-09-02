const student = {
	PID: 1111,
	GPA: 4.5
};
ayo();

function ayo() {
	alert('BITCH ASS');
}

const btn = document.querySelector('button');
btn.addEventListener('click', ayo);

const nums = [ 20, 10, 24, 12, 18 ];
const moreNums = [ 1, 2 ];

const [ firstNum, secondNum, , fourthNum ] = nums;
const combNums = [ ...nums, ...moreNums ];

const nums2 = nums.map(function(num) {
	return num * 2;
});

const nums3 = nums.map((n) => {
	return n * 2;
});

const nums4 = nums.map((n) => n * 2); //nums2,3,4 all do the same  thing.

const square = (x) => {
	return x * x;
};
const shorterSq = (n) => n * n;

const twoDimArray = [];
for (let i = 0; i < 3; i++) {
	twoDimArray[i] = new Array();
	for (let j = 0; j < 3; j++) {
		twoDimArray[i][j] = i + j;
	}
}
