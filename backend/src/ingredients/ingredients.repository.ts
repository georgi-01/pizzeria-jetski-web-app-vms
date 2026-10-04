import { Injectable } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class IngredientsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async count() {
    return this.prisma.ingredients.count();
  }
}