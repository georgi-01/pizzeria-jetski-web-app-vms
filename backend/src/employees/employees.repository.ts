import { Injectable } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class EmployeesRepository {
  constructor(private readonly prisma: PrismaService) { }

  async count() {
    return this.prisma.employees.count({
      where: {
        is_deleted: false,
      },
    });
  }
}