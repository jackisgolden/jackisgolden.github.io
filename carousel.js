const track = document.querySelector('.carousel_track');
const slides = Array.from(track.children);
const nextButton = document.querySelector('.carousel_button_right');
const prevButton = document.querySelector('.carousel_button_left');
const dotsNav = document.querySelector('.carousel_nav');
const dots = Array.from(dotsNav.children);

const slideSize = slides[0].getBoundingClientRect();
const slideWidth = slideSize.width;

slides[0].classList.add('first');
slides[slides.length - 1].classList.add('last');

const setSlidePosition = (slide, i) => {
	slide.style.left = slideWidth * i + 'px';
};
slides.forEach(setSlidePosition);

const moveToSlide = (track, currentSlide, targetSlide) => {
	track.style.transform = 'translateX(-' + targetSlide.style.left + ')';
	currentSlide.classList.remove('current_slide');
	targetSlide.classList.add('current_slide');
};

const updateDots = (currentDot, targetDot) => {
	currentDot.classList.remove('current_slide');
	targetDot.classList.add('current_slide');
};

const updateArrows = (targetSlide) => {
	if (targetSlide.classList.contains('first')) {
		prevButton.classList.add('is-hidden');
	} else if (targetSlide.classList.contains('last')) {
		nextButton.classList.add('is-hidden');
	}

	if (!targetSlide.classList.contains('first')) {
		prevButton.classList.remove('is-hidden');
	}
	if (!targetSlide.classList.contains('last')) {
		nextButton.classList.remove('is-hidden');
	}
};

function btnClick(e) {
	const currentSlide = track.querySelector('.current_slide');
	const currentDot = dotsNav.querySelector('.current_slide');
	let targetSlide;

	if (e.currentTarget.classList.contains('carousel_button_right')) {
		targetSlide = currentSlide.nextElementSibling;
		targetDot = currentDot.nextElementSibling;
	} else {
		targetSlide = currentSlide.previousElementSibling;
		targetDot = currentDot.previousElementSibling;
	}
	moveToSlide(track, currentSlide, targetSlide);
	updateDots(currentDot, targetDot);
	updateArrows(targetSlide);
}

nextButton.addEventListener('click', btnClick, false);

prevButton.addEventListener('click', btnClick, false);

dotsNav.addEventListener('click', (e) => {
	const targetDot = e.target.closest('button');
	if (!targetDot) return;

	const currentSlide = track.querySelector('.current_slide');
	const currentDot = dotsNav.querySelector('.current_slide');
	const targetIndex = dots.findIndex((dot) => dot === targetDot);
	const targetSlide = slides[targetIndex];

	moveToSlide(track, currentSlide, targetSlide);
	updateDots(currentDot, targetDot);
	updateArrows(targetSlide);
});