const track = document.querySelector('.carousel_track');
const slides = Array.from(track.children);
const nextButton = document.querySelector('.carousel_button_right');
const prevButton = document.querySelector('.carousel_button_left');
const dotsNav = document.querySelector('.carousel_nav');
const dots = Array.from(dotsNav.children);

const slideSize = slides[0].getBoundingClientRect();
const slideWidth = slideSize.width;

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
const updateArrows = (index, length) => {};
nextButton.addEventListener('click', (e) => {
	const currentSlide = track.querySelector('.current_slide');
	const nextSlide = currentSlide.nextElementSibling;
	const currentDot = dotsNav.querySelector('.current_slide');
	const nextDot = currentDot.nextElementSibling;
	moveToSlide(track, currentSlide, nextSlide);
	updateDots(currentDot, nextDot);
});

prevButton.addEventListener('click', (e) => {
	const currentSlide = track.querySelector('.current_slide');
	const prevSlide = currentSlide.previousElementSibling;
	const currentDot = dotsNav.querySelector('.current_slide');
	const prevDot = currentDot.previousElementSibling;
	moveToSlide(track, currentSlide, prevSlide);
	updateDots(currentDot, prevDot);
});

dotsNav.addEventListener('click', (e) => {
	const targetDot = e.target.closest('button');
	if (!targetDot) return;

	const currentSlide = track.querySelector('.current_slide');
	const currentDot = dotsNav.querySelector('.current_slide');
	const targetIndex = dots.findIndex((dot) => dot === targetDot);
	const targetSlide = slides[targetIndex];

	moveToSlide(track, currentSlide, targetSlide);

	updateDots(currentDot, targetDot);

	if (targetIndex === 0) {
		prevButton.classList.add('is-hidden');
		nextButton.classList.remove('is-hidden');
	} else if (targetIndex === slides.length - 1) {
		nextButton.classList.add('is-hidden');
		prevButton.classList.remove('is-hidden');
	}
});
