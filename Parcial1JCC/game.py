
import pygame
import random
import os
from pygame import mixer
from spritesheet import SpriteSheet
from enemy import Enemy
from player import Player

mixer.init()
pygame.init()

SCREEN_W = 400
SCREEN_H = 600

screen = pygame.display.set_mode((SCREEN_W, SCREEN_H))
pygame.display.set_caption('JUMPER')

clock = pygame.time.Clock()
FPS = 60

pygame.mixer.music.load('assets/music.mp3')
pygame.mixer.music.set_volume(0.6)
pygame.mixer.music.play(-1, 0.0)
jump_fx = pygame.mixer.Sound('assets/jump.mp3')
jump_fx.set_volume(0.5)
death_fx = pygame.mixer.Sound('assets/death.mp3')
death_fx.set_volume(0.5)

SCROLL_H = 200
G = 1
MAX_PLAT = 10
scroll = 0
bg_scroll = 0
game_over = False
score = 0
fade_counter = 0

if os.path.exists('score.txt'):
	with open('score.txt', 'r') as file:
		high_score = int(file.read())
else:
	high_score = 0

WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
PANEL = (153, 217, 234)

font_small = pygame.font.SysFont('Lucida Sans', 20)
font_big = pygame.font.SysFont('Lucida Sans', 24)

player_image = pygame.image.load('assets/frog.png').convert_alpha()
bg_image = pygame.image.load('assets/bg.png').convert_alpha()
platform_image = pygame.image.load('assets/wood.png').convert_alpha()
bird_sheet_img = pygame.image.load('assets/bird.png').convert_alpha()
bird_sheet = SpriteSheet(bird_sheet_img)

def draw_text(text, font, text_col, x, y):
	img = font.render(text, True, text_col)
	screen.blit(img, (x, y))

def draw_panel():
	pygame.draw.rect(screen, PANEL, (0, 0, SCREEN_W, 30))
	pygame.draw.line(screen, WHITE, (0, 30), (SCREEN_W, 30), 2)
	draw_text('SCORE: ' + str(score), font_small, WHITE, 0, 0)

def draw_bg(bg_scroll):
	screen.blit(bg_image, (0, 0 + bg_scroll))
	screen.blit(bg_image, (0, -600 + bg_scroll))

class Platform(pygame.sprite.Sprite):
	def __init__(self, x, y, width, moving):
		pygame.sprite.Sprite.__init__(self)
		self.image = pygame.transform.scale(platform_image, (width, 10))
		self.moving = moving
		self.move_counter = random.randint(0, 50)
		self.direction = random.choice([-1, 1])
		self.speed = random.randint(1, 2)
		self.rect = self.image.get_rect()
		self.rect.x = x
		self.rect.y = y

	def update(self, scroll):
		if self.moving == True:
			self.move_counter += 1
			self.rect.x += self.direction * self.speed

		if self.move_counter >= 100 or self.rect.left < 0 or self.rect.right > SCREEN_W:
			self.direction *= -1
			self.move_counter = 0

		self.rect.y += scroll

		if self.rect.top > SCREEN_H:
			self.kill()

player = Player(SCREEN_W // 2, SCREEN_H - 150, player_image)
platform_group = pygame.sprite.Group()
enemy_group = pygame.sprite.Group()

platform = Platform(SCREEN_W // 2 - 50, SCREEN_H - 50, 100, False)
platform_group.add(platform)

run = True
while run:

	clock.tick(FPS)

	if game_over == False:
		scroll = player.move(G, SCREEN_W, platform_group, SCROLL_H, jump_fx=jump_fx)

		bg_scroll += scroll
		if bg_scroll >= 600:
			bg_scroll = 0
		draw_bg(bg_scroll)

		if len(platform_group) < MAX_PLAT:
			p_w = random.randint(40, 60)
			p_x = random.randint(0, SCREEN_W - p_w)
			p_y = platform.rect.y - random.randint(80, 120)
			p_type = random.randint(1, 2)
			if p_type == 1 and score > 500:
				p_moving = True
			else:
				p_moving = False
			platform = Platform(p_x, p_y, p_w, p_moving)
			platform_group.add(platform)

		platform_group.update(scroll)

		if len(enemy_group) == 0 and score > 1500:
			enemy = Enemy(SCREEN_W, 100, bird_sheet, 1.5)
			enemy_group.add(enemy)

		enemy_group.update(scroll, SCREEN_W)

		if scroll > 0:
			score += scroll
		pygame.draw.line(screen, WHITE, (0, score - high_score + SCROLL_H), (SCREEN_W, score - high_score + SCROLL_H), 3)
		draw_text('HIGH SCORE', font_small, WHITE, SCREEN_W - 130, score - high_score + SCROLL_H)

		platform_group.draw(screen)
		enemy_group.draw(screen)
		player.draw(screen)

		draw_panel()

		if player.rect.top > SCREEN_H:
			game_over = True
			death_fx.play()
		if pygame.sprite.spritecollide(player, enemy_group, False):
			if pygame.sprite.spritecollide(player, enemy_group, False, pygame.sprite.collide_mask):
				game_over = True
				death_fx.play()
	else:
		if fade_counter < SCREEN_W:
			fade_counter += 5
			for y in range(0, 6, 2):
				pygame.draw.rect(screen, BLACK, (0, y * 100, fade_counter, 100))
				pygame.draw.rect(screen, BLACK, (SCREEN_W - fade_counter, (y + 1) * 100, SCREEN_W, 100))
		else:
			draw_text('MORISTE', font_big, WHITE, 130, 200)
			draw_text('SCORE: ' + str(score), font_big, WHITE, 130, 250)
			draw_text('ESPACIO PARA REINTENTAR', font_big, WHITE, 40, 300)
			if score > high_score:
				high_score = score
				with open('score.txt', 'w') as file:
					file.write(str(high_score))
			key = pygame.key.get_pressed()
			if key[pygame.K_SPACE]:
				game_over = False
				score = 0
				scroll = 0
				fade_counter = 0
				player.rect.center = (SCREEN_W // 2, SCREEN_H - 150)
				enemy_group.empty()
				platform_group.empty()
				platform = Platform(SCREEN_W // 2 - 50, SCREEN_H - 50, 100, False)
				platform_group.add(platform)

	for event in pygame.event.get():
		if event.type == pygame.QUIT:
			if score > high_score:
				high_score = score
				with open('score.txt', 'w') as file:
					file.write(str(high_score))
			run = False
	pygame.display.update()

pygame.quit()

