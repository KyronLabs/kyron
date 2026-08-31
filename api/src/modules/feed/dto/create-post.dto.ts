import { IsNotEmpty, IsString, MaxLength } from 'class-validator';

export class CreatePostDto {
  @IsString()
  @IsNotEmpty({ message: 'A post needs some content.' })
  @MaxLength(3000, { message: 'A post cannot exceed 3000 characters.' })
  content!: string;

  // authorId used to be accepted here. With the route unguarded that let any
  // caller post as any user by naming them in the body; the author now comes
  // from the verified token and cannot be supplied at all.
}
