import pygame
from pygame.sprite import Sprite

class Player(Sprite):
	def __init__(self, x, y,jumpy_image,):
		self.image = pygame.transform.scale(jumpy_image, (45, 45))
		self.width = 25
		self.height = 40
		self.rect = pygame.Rect(0, 0, self.width, self.height)
		self.rect.center = (x, y)
		self.vel_y = 0
		self.flip = False

	def move(self, g, sc_w, plat_g, scroll_h, jump_fx):
		scroll = 0
		dx = 0
		dy = 0

		key = pygame.key.get_pressed()
		if key[pygame.K_a]:
			dx = -6
			self.flip = True
		if key[pygame.K_d]:
			dx = 6
			self.flip = False

		self.vel_y += g
		dy += self.vel_y

		if self.rect.left + dx < 0:
			dx = -self.rect.left
		if self.rect.right + dx > sc_w:
			dx = sc_w - self.rect.right

		for platform in plat_g:
			if platform.rect.colliderect(self.rect.x, self.rect.y + dy, self.width, self.height):
				if self.rect.bottom < platform.rect.centery:
					if self.vel_y > 0:
						self.rect.bottom = platform.rect.top
						dy = 0
						self.vel_y = -20
						jump_fx.play()

		if self.rect.top <= scroll_h:
			if self.vel_y < 0:
				scroll = -dy

		self.rect.x += dx
		self.rect.y += dy + scroll

		self.mask = pygame.mask.from_surface(self.image)

		return scroll

	def draw(self, screen):
		screen.blit(pygame.transform.flip(self.image, self.flip, False), (self.rect.x - 12, self.rect.y - 5))
