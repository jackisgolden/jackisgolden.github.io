const track = document.querySelector('.carousel_track');
const slides = Array.from(track.children);
const nextButton = document.querySelector('.carousel_button_right');
const prevButton = document.querySelector('.carousel_button_left');
const dotsNav = document.querySelector('.carousel_nav');
const dots = Array.from(dotsNav.children);

const slideSize = slides[0].getBoundingClientRect();
const slideWidth = slideSize.width;


const setSlidePosition = (slide, i) => {
    slide.style.left = slideWidth * 30 * i + 'px';
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


prevButton.addEventListener('click', () => {
    const currentSlide = track.querySelector('.current_slide');
    const prevSlide = currentSlide.previousElementSibling;
    const currentDot = dotsNav.querySelector('.current_slide');
    const prevDot = currentDot.previousElementSibling;
    moveToSlide(track, currentSlide, prevSlide);
    updateDots(currentDot, prevDot);
    updateArrows(currentSlide);
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

    updateArrows(currentSlide, targetSlide);
});